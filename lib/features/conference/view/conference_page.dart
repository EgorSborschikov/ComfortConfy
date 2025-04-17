import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/features/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/io.dart';
import '../../../services/rest_api/leave_conference.dart';
import '../widgets/participant_card.dart';
import 'package:image/image.dart' as img;

class ConferencePage extends StatefulWidget{
  final String roomId;
  final String conferenceName;
  final bool isHost;

  const ConferencePage({super.key, required this.roomId, required this.conferenceName, required this.isHost,});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> with WidgetsBindingObserver {
  final SupabaseClient _supabase = Supabase.instance.client;
  late RealtimeChannel _participantsChannel;

  List<Map<String, dynamic>> participants = [];

  late IOWebSocketChannel _channel;

  late FlutterSoundRecorder _recorder;
  late CameraController _cameraController;

  bool _isMicOn = true;
  bool _isCameraOn = true;

  StreamController<Uint8List> recordingDataController = StreamController<Uint8List>();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final status = await [Permission.camera, Permission.microphone].request();
    if (status[Permission.camera]!.isGranted &&
        status[Permission.microphone]!.isGranted) {
      _initializeWebsocket();
      _initializeParticipants();
      _setupRealtime();
      _initializeCamera();
      _initializeMicrophone();
    } else {
      // Обработка отказа в разрешениях
      _handlePermissionDenied();
    }
  }

  Future<void> _initializeParticipants() async {
    try {
      final response = await _supabase
        .from('participants')
        .select('''
          user_id,
          mic_enabled,
          camera_enabled,
          profiles:user_id (email)
        ''')
        .eq('conference_id', widget.roomId);

      setState(() {
        participants = response.map((p) => {
          'user_id': p['user_id'],
          'email': p['profiles']?['email'] ?? 'Unknown', // Добавляем проверку
          'isMicOn': p['mic_enabled'] ?? true,         // Исправляем ключи
          'isCameraOn': p['camera_enabled'] ?? true,   // согласно ожиданиям карточки
          'videoStream': null, // Инициализируем поток видео
        }).toList();
      });
    } catch (e) {
      print('Error fetching participants: $e');
    }
  }

  void _setupRealtime() {
    _participantsChannel = _supabase.channel('conference_${widget.roomId}');
    
    _participantsChannel.onPostgresChanges(
      event: PostgresChangeEvent.all, 
      schema: 'public',
      table: 'participants',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'conference_id',
        value: widget.roomId,
      ),
      callback: (payload){
        _handleParticipantEvent(payload);
      }
    ).subscribe();
  }

  void _handleParticipantEvent(dynamic payload) {
    final event = payload as Map<String, dynamic>;
    switch (event['eventType']) {
      case 'INSERT':
        _addParticipant(event['new']);
        break;
      case 'UPDATE':
        _updateParticipant(event['new']);
        break;
      case 'DELETE':
        _removeParticipant(event['old']);
        break;
    }
  }

  void _addParticipant(Map<String, dynamic> participant) {
    setState(() {
      participants.add({
        'user_id': participant['user_id'],
        'email': participant['profiles']?['email'] ?? 'Unknown',
        'isMicOn': participant['mic_enabled'],
        'isCameraOn': participant['camera_enabled'],
        'videoStream': null,
      });
    });
  }

  void _updateParticipant(Map<String, dynamic> updated) {
    setState(() {
      final index = participants.indexWhere(
        (p) => p['user_id'] == updated['user_id']
      );
      if (index != -1) {
        participants[index] = {
          ...participants[index],
          'isMicOn': updated['mic_enabled'],
          'isCameraOn': updated['camera_enabled'],
        };
      }
    });
  }

  void _removeParticipant(Map<String, dynamic> removed) {
    setState(() {
      participants.removeWhere(
        (p) => p['user_id'] == removed['user_id']
      );
    });
  }

  void _initializeWebsocket() {
    try {
      print('Попытка подключения к WebSocket...');
      _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$baseUrl:8000/ws/${widget.roomId}'),
      );
      print('Подключение к WebSocket успешно.');

      _channel.stream.handleError((error) {
        print('WebSocket error: $error');
        _handleWebSocketError(error);

      }).listen((message) {
        print('Получено сообщение: $message');
        setState(() {
          participants = _parseParticipants(message);
          print('Updated participants: $participants'); // Отладочный принт
        });

      }, onDone: () {
        print('WebSocket connection closed.');
      });

    } catch (e) {
      print('WebSocket init error: $e');
      _handleWebSocketError(e);
    }
  }

  void _handlePermissionDenied() {
    // Показать уведомление пользователю или повторно запросить разрешения
    print('Permission denied. Please grant camera and microphone permissions.');
  }

  void _handleWebSocketError(dynamic error) {
    // Обработка ошибок WebSocket, например, повторная попытка подключения
    print('WebSocket error occurred: $error');
    // Возможно, добавить логику для повторного подключения
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
      await _cameraController.initialize();
      
      if (_isCameraOn) {
        await _cameraController.startImageStream((image) {
          // Конвертация CameraImage в JPEG
          // ignore: unused_local_variable
          final planes = image.planes.map((plane) => plane.bytes).toList();
          final jpeg = img.encodeJpg(
            img.Image.fromBytes(
              image.width,
              image.height,
              image.planes[0].bytes,
              format: img.Format.argb,
            ),
          );
          _channel.sink.add(jpeg);
        });
      }
    } catch (e) {
      print('Camera error: $e');
    }
  }

  void _initializeMicrophone() async {
    _recorder = FlutterSoundRecorder();
    await _recorder.openRecorder();

    if (_isMicOn) {
      await _recorder.startRecorder(
        toStream: recordingDataController.sink,
        codec: Codec.pcm16, // Используйте подходящий кодек
        sampleRate: 16000,
        numChannels: 1,
        bitRate: 16000,
      );
    }
  }

  List<Map<String, dynamic>> _parseParticipants(dynamic message) {
    try {
      if (message is String) {
        final data = json.decode(message);
        if (data is Map<String, dynamic> && data.containsKey('participants')) {
          return List<Map<String, dynamic>>.from(data['participants']);
        }
        return [];
      } 
      
      if (message is Uint8List) {
        final image = img.decodeImage(message);
        if (image != null) {
          final png = img.encodePng(image);
          return [
            {
              'email': _supabase.auth.currentUser?.email ?? 'Unknown',
              'isMicOn': _isMicOn,
              'isCameraOn': _isCameraOn,
              'videoStream': png,
            }
          ];
        }
        return [];
      }
    } catch (e) {
      print('Parse error: $e');
    }
    
    return []; // Гарантированный возврат List
  }

  void _toggleMic() async {
    setState(() => _isMicOn = !_isMicOn);
    
    if (_isMicOn) {
      await _recorder.startRecorder(
        toStream: recordingDataController.sink, // Используем StreamController напрямую
        codec: Codec.defaultCodec,
        sampleRate: 16000,
      );
      
      // Подписываемся на поток аудиоданных и отправляем через WebSocket
      recordingDataController.stream.listen((data) {
        _channel.sink.add(data);
      });
    } else {
      await _recorder.stopRecorder();
      recordingDataController.stream.drain(); // Очищаем поток
    }
  }

  void _toggleCamera() async {
    setState(() => _isCameraOn = !_isCameraOn);
    
    if (_isCameraOn) {
      await _cameraController.resumePreview();
      await _cameraController.startImageStream((image) {
      // Повторно добавляем обработчик кадров
      final jpeg = img.encodeJpg(
        img.Image.fromBytes(
          image.width,
          image.height,
          image.planes[0].bytes,
          format: img.Format.argb,
        ),
      );
      _channel.sink.add(jpeg);
    });
    } else {
      await _cameraController.stopImageStream();
      await _cameraController.pausePreview();
    }
  }

  @override
  void dispose() {
    _participantsChannel.unsubscribe();
    _channel.sink.close();
    _recorder.closeRecorder();
    _cameraController.dispose();
    recordingDataController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.conferenceName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _toggleMic,
              icon: Icon(_isMicOn 
                ? CupertinoIcons.mic
                : CupertinoIcons.mic_off
                ),
              color: _isMicOn ? CupertinoColors.activeGreen : CupertinoColors.inactiveGray,
            ),
            IconButton(
              icon: Icon(_isCameraOn 
              ? CupertinoIcons.video_camera_solid
              : Icons.videocam_off_rounded
            ),
              onPressed: _toggleCamera,
              color: _isCameraOn ? CupertinoColors.activeGreen : CupertinoColors.inactiveGray,
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.clear_thick_circled, color: CupertinoColors.destructiveRed,),
              onPressed: () {
                _isMicOn = false;
                _isCameraOn = false;
                leaveConference(widget.roomId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage()
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: participants.length,
          itemBuilder: (context, index){
            final participant = participants[index];
            print('Building card for participant: $participant');
            return ParticipantCard(
              email: participant['email'],
              isMicOn: participant['isMicOn'],
              isCameraOn: participant['isCameraOn'],
              videoStream: participant['videoStream'],
            );
          },
        ),
      ),
    );
  }
}