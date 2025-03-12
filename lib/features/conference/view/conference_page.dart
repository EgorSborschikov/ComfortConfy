import 'package:flutter/material.dart';
import 'package:stream_video/src/call/call.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class ConferencePage extends StatefulWidget{
  final Call call;
  const ConferencePage({super.key, required this.call});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamCallContainer(
        call: widget.call,
        callContentBuilder: (
            BuildContext context,
            Call call,
            CallState callState,
            ) {
          return StreamCallContent(
            call: call,
            callState: callState,
            callControlsBuilder: (
                BuildContext context,
                Call call,
                CallState callState,
                ) {
              final localParticipant = callState.localParticipant!;
              return StreamCallControls(
                options: [
                  CallControlOption(
                    icon: const Icon(Icons.chat_outlined),
                    onPressed: () {
                      // Open your chat window
                    },
                  ),
                  FlipCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  AddReactionOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  ToggleMicrophoneOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  ToggleCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  LeaveCallOption(
                    call: call,
                    onLeaveCallTap: () {
                      call.leave();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}