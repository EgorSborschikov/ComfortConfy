import 'package:comfort_confy/mobile/components/overlays/option_service.dart';
import 'package:flutter/material.dart';

class UsersDataModel extends StatefulWidget {
  final String nickname;
  final String profilePicture;

  const UsersDataModel({
    super.key,
    required this.nickname,
    required this.profilePicture,
  });

  @override
  _UsersDataModelState createState() => _UsersDataModelState();
}

class _UsersDataModelState extends State<UsersDataModel> {
  OverlayEntry? _overlayEntry;

  void _showOptionService() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return OptionService(
          onAddToContacts: _addToContacts,
          onBlockUser: _blockUser,
          onDismiss: _hideOptionService, 
          userId: '', 
          contactId: '',
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideOptionService() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _addToContacts() async {
    // Implement adding to contacts logic here
    print('User added to contacts');
  }

  Future<void> _blockUser() async {
    // Implement blocking user logic here
    print('User blocked');
  }

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
                backgroundImage: widget.profilePicture.isNotEmpty ? NetworkImage(widget.profilePicture) : null,
                child: widget.profilePicture.isEmpty
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
                      widget.nickname,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: _showOptionService,
              ),
            ],
          ),
        ),
        const Divider(), // Divider at the bottom
      ],
    );
  }
}