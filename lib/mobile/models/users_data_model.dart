import 'package:flutter/material.dart';

class UsersDataModel extends StatefulWidget{
  final String nickname;

  const UsersDataModel({
    super.key,
    required this.nickname,});

  @override
  State<UsersDataModel> createState() => _UsersDataModelState();
}

class _UsersDataModelState extends State<UsersDataModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor, // Use theme color
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 5.0),
          const CircleAvatar(
            radius: 40.0,
          ),
          const SizedBox(width: 5.0),
          Text(
            widget.nickname,
          ),
        ]
      ),
    );
  }
}