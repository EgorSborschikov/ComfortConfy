import 'package:camera/camera.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../services/api/rest/leave_conference.dart';
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
  List<Map<String, dynamic>> participants = [];

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PlatformAppBar(
          title: widget.conferenceName,
          trailing: [
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.mic_off),
            ),
            IconButton(
              icon: Icon(Icons.videocam_off),
              onPressed: () {}
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                //_leaveConference(widget.roomId);
              },
            ),
          ],    
        ),
        body: ListView.builder(
          itemCount: participants.length,
          itemBuilder: (context, index) {
            final participant = participants[index];
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