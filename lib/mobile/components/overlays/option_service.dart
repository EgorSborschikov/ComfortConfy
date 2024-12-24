import 'dart:ui';
import 'package:comfort_confy/services/add_users_in_contacts_list_service/add_users_in_contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OptionService extends StatefulWidget {
  final VoidCallback onAddToContacts;
  final VoidCallback onBlockUser;
  final VoidCallback onDismiss;
  
  final String userId;
  final String contactId;

  const OptionService({
    super.key,
    required this.onAddToContacts,
    required this.onBlockUser,
    required this.onDismiss, 
    required this.userId, 
    required this.contactId,
  });

  @override
  State<OptionService> createState() => _OptionServiceState();
}

class _OptionServiceState extends State<OptionService> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            top: 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: CupertinoButton(
                    onPressed: () async {
                      //await addUserInContactsList(widget.userId, widget.contactId);
                      widget.onDismiss();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.addToContacts,
                      style: const TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: CupertinoButton(
                    onPressed: () {
                      widget.onBlockUser();
                      widget.onDismiss();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.addToBlockList,
                      style: const TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                IconButton(
                  onPressed: widget.onDismiss, 
                  icon: const Icon(CupertinoIcons.back)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
