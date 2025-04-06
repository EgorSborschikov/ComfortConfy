import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestMicrophonePermission() async{
    PermissionStatus status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return status.isGranted;
  }
}