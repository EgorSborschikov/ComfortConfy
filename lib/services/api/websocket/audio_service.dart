import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';

class AudioService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;

  Future<void> initRecorder() async {
    await _recorder.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<void> startRecording(StreamSink<Uint8List> onData) async {
    if(!_isRecorderInitialized) await initRecorder();

    await _recorder.startRecorder(
      toStream: onData,
      codec: Codec.aacMP4
    );
  }

  Future<void> stopRecorder() async {
    await _recorder.stopRecorder();
  }

  void dispose() {
    _recorder.closeRecorder();
    _isRecorderInitialized = false;
  }
}