import 'package:flutter/material.dart';
import 'package:stream_video/stream_video.dart';
import '../../conference/view/conference_page.dart';

Future<void> conferenceRoute(context) async {
  try {
    var call = StreamVideo.instance.makeCall(
      callType: StreamCallType.liveStream(),
      id: 'hUCKfSjKqRrZ'
    );

    await call.getOrCreate();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConferencePage(call: call),
        ),
      );
  } catch(e) {
    debugPrint('Error joining or creating call: $e');
    debugPrint(e.toString());
  }
}