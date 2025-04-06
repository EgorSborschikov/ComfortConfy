import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:camera/camera.dart';

class VideoService {
  late CameraController _controller;
  late StreamController<Uint8List> _videoStreamController;


  Future<void> initializeCamera(CameraDescription camera) async{
    _controller = CameraController(
      camera, 
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller.initialize();

    _videoStreamController = StreamController<Uint8List>();

    _controller.startImageStream((CameraImage image) {
      // Convert CameraImage to Uint8List and add to the stream
      final Uint8List imageBytes = _convertCameraImage(image);
      _videoStreamController.add(imageBytes);
    });
  }

  Uint8List _convertCameraImage(CameraImage image) {
    // Convert the CameraImage to Uint8List
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  Stream<Uint8List> get videoStream => _videoStreamController.stream;

  Future<void> startVideo(StreamSink<Uint8List> onData) async {
    // Start sending video data to the provided sink
    videoStream.listen((data) {
      onData.add(data);
    });
  }

  Future<void> stopVideo() async {
    // Stop sending video data
    await _controller.stopImageStream();
  }

  void dispose() {
    _controller.dispose();
  }
}