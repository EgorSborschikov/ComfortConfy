import 'dart:typed_data';
import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
  final String email;
  final bool isMicOn;
  final bool isCameraOn;
  final Uint8List? videoStream;

  const ParticipantCard({
    super.key,
    required this.email,
    required this.isMicOn,
    required this.isCameraOn,
    this.videoStream,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          if (isCameraOn)
            AspectRatio(
              aspectRatio: 3/4,
              child: videoStream != null 
                  ? Image.memory(videoStream!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 50),
                    ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  isMicOn ? Icons.mic : Icons.mic_off,
                  color: isMicOn ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}