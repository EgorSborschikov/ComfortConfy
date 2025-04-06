import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/services/api/websocket/audio_service.dart';
import 'package:comfort_confy/services/api/websocket/permission_service.dart';
import 'package:comfort_confy/services/api/websocket/video_service.dart';
import 'package:comfort_confy/services/api/websocket/websocket_service.dart';
import 'package:flutter/material.dart';
import '../../../config.dart';
import 'dart:async';
import 'dart:typed_data';

import '../../../services/api/rest/leave_conference.dart';

class ConferencePage extends StatefulWidget{
  final String roomId;
  final String conferenceName;
  final bool isHost;

  const ConferencePage({super.key, required this.roomId, required this.conferenceName, required this.isHost,});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> with WidgetsBindingObserver {
  late WebsocketService _websocketService;
  late AudioService _audioService;
  late VideoService _videoService;
  late PermissionService _permissionService;
  late StreamController<Uint8List> _audioStreamController;
  //late StreamController<Uint8List> _videoStreamController;
  bool _isRecording = false;
  bool _isCameraOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

   _websocketService = WebsocketService('ws://$baseUrl/ws/${widget.roomId}');
   _audioService = AudioService();
   //_videoService = VideoService();
   _audioStreamController = StreamController<Uint8List>();

   _audioStreamController.stream.listen((data) {
      _websocketService.send(data);
    });

    /*_videoStreamController.stream.listen((data) {
      _websocketService.send(data);
    });*/

   _requestPermissions();
   _startRecording();
  }

  Future<void> _requestPermissions() async{
    await _permissionService.requestMicrophonePermission();
    await _permissionService.requestCameraPermission();
  }

  Future<void> _startRecording() async{
    await _audioService.startRecording(_audioStreamController.sink);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _audioService.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  /*Future<void> _startVideo() async {
    await _videoService.startVideo(_videoStreamController.sink);
    setState(() {
      _isCameraOn = true;
    });
  }
  
  Future<void> _stopVideo() async {
    await _videoService.stopVideo();
    setState(() {
      _isCameraOn = false;
    });
  }*


  void _toggleCamera() {
    if (_isCameraOn) {
      _stopVideo();
    } else {
      _startVideo();
    }
  }*/

  void _exitConference() {
    if (widget.isHost) {
      // Отправить сообщение всем участникам для завершения конференции
      _websocketService.send('end_conference');
    }
    // Закрыть соединение для текущего пользователя
    _websocketService.dispose();
    Navigator.of(context).pop();
  }

  void _leaveConference(String roomId) async {
    try {
      await leaveConference(roomId);
      // Возврат на предыдущий экран или на экран поиска конференций
      Navigator.pop(context);
    } catch (e) {
      // Обработка ошибки выхода
      print('Ошибка при выходе из конференции: $e');
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopRecording();
    //_stopVideo();
    _audioService.dispose();
    _videoService.dispose();
    _websocketService.dispose();
    _audioStreamController.close();
    //_videoStreamController.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _stopRecording();
      //_stopVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Запрещаем выход по свайпу
        return false;
      },
      child: Scaffold(
        appBar: PlatformAppBar(
          title: widget.conferenceName,
          trailing: [
            IconButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
            ),
            IconButton(
              icon: Icon(_isCameraOn ? Icons.videocam_off : Icons.videocam),
              onPressed: () {}//_toggleCamera,
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _leaveConference(widget.roomId);
              },
            ),
          ],
        ),
      ),
    );
  }
}