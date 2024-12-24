import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String conference_name;
  const CallAppBar({
    super.key,
    required this.conference_name,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120), // Увеличьте высоту AppBar
      child: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              conference_name,
              style: const TextStyle(
                fontFamily: 'Kokoro',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10), // Отступ между заголовком и иконками
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Логика для включения/выключения микрофона
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // Логика для включения/выключения динамика
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: () {
                    // Логика для включения/выключения камеры
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.screen_share),
                  onPressed: () {
                    // Логика для демонстрации экрана
                  },
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.clear_circled),
                  color: Colors.red,
                  onPressed: () {
                    // Логика для завершения конференции
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}