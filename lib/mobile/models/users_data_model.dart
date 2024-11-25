import 'package:flutter/material.dart';

class UsersDataModel extends StatelessWidget {
  final String nickname;

  const UsersDataModel({
    super.key,
    required this.nickname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 5.0),
          /*CircleAvatar(
            radius: 40.0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundImage: profilePicture != null ? NetworkImage(profilePicture!) : null,
            child: profilePicture == null
              ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF5727EC),
                )
              : null,
          ),*/
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              nickname,
              //style: TextStyle(fontSize: 16.0), // У вас могут быть другие стили
            ),
          ),
        ],
      ),
    );
  }
}
