//ЭТО ТЕСТОВЫЙ ВАРИАНТ
//Продумать связь и реализацию микросервиса при связи с gRPC streaming. 
import 'package:audio_session/audio_session.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CallFeaturesService {
  bool isSpeakerOn = false;
  bool isCameraOn = false;
  bool isMicOn = false;
  bool isDemoEnabled = false;

  //final AudioSession _audioSession = AudioSession();
  CameraController? _cameraController;

  CallFeaturesService() {
    if (Platform.isAndroid || Platform.isIOS) {
      _initCamera();
      //_initAudioSession();
    } else {
      print('Camera and audio session initialization are not supported on this platform.');
    }
  }

  Future<void> _initCamera() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras.first, ResolutionPreset.high);
      await _cameraController!.initialize();
    } else {
      print('Camera initialization is not supported on this platform.');
    }
  }

  /*Future<void> _initAudioSession() async {
    if (Platform.isIOS) {
      await _audioSession.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionMode: AVAudioSessionMode.voiceChat,
        avAudioSessionCategoryOptions: [
          AVAudioSessionCategoryOptions.allowBluetooth,
          AVAudioSessionCategoryOptions.defaultToSpeaker,
        ],
      ));
    } else if (Platform.isAndroid) {
      await _audioSession.configure(const AudioSessionConfiguration(
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
          flags: AndroidAudioFlags.none,
        ),
      ));
    } else {
      print('Audio session initialization is not supported on this platform.');
    }
  }

  Future<void> toggleSpeaker() async {
    if (Platform.isAndroid || Platform.isIOS) {
      isSpeakerOn = !isSpeakerOn;
      await _audioSession.setActive(isSpeakerOn);
      print(isSpeakerOn ? 'Speaker is on' : 'Speaker is off');
    } else {
      print('Speaker toggle is not supported on this platform.');
    }
  }*/

  Future<void> toggleCamera() async {
    if (Platform.isAndroid || Platform.isIOS) {
      isCameraOn = !isCameraOn;
      if (isCameraOn) {
        await _cameraController!.startImageStream((image) {});
        print('Camera is on');
      } else {
        await _cameraController!.stopImageStream();
        print('Camera is off');
      }
    } else {
      print('Camera toggle is not supported on this platform.');
    }
  }

  Future<void> toggleMic() async {
    if (Platform.isAndroid || Platform.isIOS) {
      isMicOn = !isMicOn;
      if (isMicOn) {
        await Permission.microphone.request();
        print('Mic is on');
      } else {
        await Permission.microphone.request();
        print('Mic is off');
      }
    } else {
      print('Mic toggle is not supported on this platform.');
    }
  }

  Future<void> toggleDemo() async {
    isDemoEnabled = !isDemoEnabled;
    print(isDemoEnabled ? 'Demo is enabled' : 'Demo is disabled');
  }

  void endCall() {
    print('Call ended');
    _cameraController?.dispose();
  }
}
