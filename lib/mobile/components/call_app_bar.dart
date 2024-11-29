import 'package:comfort_confy/server/services/call_features_service/call_features_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CallAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String nickname;
  final String profilePicture;

  const CallAppBar({
    super.key,
    required this.nickname,
    required this.profilePicture,
  });

  @override
  State<CallAppBar> createState() => _CallAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CallAppBarState extends State<CallAppBar> {
  final CallFeaturesService _callFeaturesService = CallFeaturesService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePicture),
          ),
          const SizedBox(width: 10),
          Text(widget.nickname),
        ],
      ),
      actions: [
        /*IconButton(
          icon: Icon(_callFeaturesService.isSpeakerOn ? FontAwesomeIcons.volumeUp : FontAwesomeIcons.volumeMute),
          onPressed: _callFeaturesService.toggleSpeaker,
        ),*/
        IconButton(
          icon: Icon(_callFeaturesService.isCameraOn ? FontAwesomeIcons.video : FontAwesomeIcons.videoSlash),
          onPressed: _callFeaturesService.toggleCamera,
        ),
        IconButton(
          icon: Icon(_callFeaturesService.isMicOn ? FontAwesomeIcons.microphone : FontAwesomeIcons.microphoneSlash),
          onPressed: _callFeaturesService.toggleMic,
        ),
        IconButton(
          icon: Icon(_callFeaturesService.isDemoEnabled ? FontAwesomeIcons.stop : FontAwesomeIcons.desktop),
          onPressed: _callFeaturesService.toggleDemo,
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.phoneSlash, color: Colors.red),
          onPressed: _callFeaturesService.endCall,
        ),
      ],
    );
  }
}
