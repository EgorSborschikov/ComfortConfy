import 'package:flutter/material.dart';

class UsersDataModel extends StatelessWidget {
  final String nickname;
  final String profilePicture;

  const UsersDataModel({
    super.key,
    required this.nickname,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 5.0),
              CircleAvatar(
                radius: 20.0,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundImage: profilePicture.isNotEmpty ? NetworkImage(profilePicture) : null,
                child: profilePicture.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 20,
                        color: Color(0xFF5727EC),
                      )
                    : null,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0), // Отступ для выравнивания текста по центру круга
                    Text(
                      nickname,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Handle the button press
                },
              ),
            ],
          ),
        ),
        const Divider(), // Divider at the bottom
      ],
    );
  }
}