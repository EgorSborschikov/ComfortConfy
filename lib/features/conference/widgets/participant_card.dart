import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget{
  final String email;
  final bool isMicOn;
  final bool isCameraOn;
  final String? videoStream;// URL или данные для видеопотока

  const ParticipantCard({super.key, required this.email, required this.isMicOn, required this.isCameraOn, this.videoStream});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Поле для видео
          if (isCameraOn && videoStream != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(videoStream!), // Виджет для отображения видео
            ),
          // Индикатор микрофона
          Icon(
            isMicOn ? Icons.mic : Icons.mic_off,
            color: isMicOn ? Colors.green : Colors.red,
          ),
          // Email пользователя
          Text(email),
        ],
      ),
    );
  } 
}