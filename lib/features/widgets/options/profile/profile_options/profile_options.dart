// profile_options.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

import '../../../action_sheets/view_delete_action_sheet.dart';
import '../../../modal_bottom_sheets/blocked_user_list/view_blocked_user_list.dart';

class ProfileOptions extends StatelessWidget {
  final BuildContext context;

  const ProfileOptions({super.key, required this.context});

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.inviteUsers)),
      );
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.other,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: const Color(0xFF5727EC),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            _copyToClipboard('https://github.com/EgorSborschikov/comfort_confy'); //должна быть ссылка на страницу с релизами
          },
          child: Row(
            children: [
              const SizedBox(width: 10), 
              Expanded(
                child: Text(AppLocalizations.of(context)!.inviteUsers),
              ),
              const Icon(CupertinoIcons.person_add),
            ],
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            _launchURL('https://t.me/ComfortConfyTechnicalSupportBOT'); // ссылка на телеграм-бота
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(AppLocalizations.of(context)!.technicalSupport),
              ),
              const Icon(CupertinoIcons.headphones),
            ],
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            _launchURL('https://github.com/EgorSborschikov/comfort_confy');
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(AppLocalizations.of(context)!.productSourceCode),
              ),
              const Icon(CupertinoIcons.chevron_left_slash_chevron_right),
            ],
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            showBlockedUsersList(context);
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(AppLocalizations.of(context)!.blockedUsersList),
              ),
              const Icon(CupertinoIcons.minus_circle),
            ],
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            deleteAccountActionBar(context);
          },
          child: Row(
            children: [
              const SizedBox(width: 10), // Отступ между иконкой и текстом
              Expanded(
                child: Text(AppLocalizations.of(context)!.deleteAccount),
              ),
              const Icon(CupertinoIcons.delete),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
