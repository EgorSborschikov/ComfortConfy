import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _copyToClipboard(BuildContext context, String text) {
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

  void _showBlockedUsersList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.blockedUsersList,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              // Здесь можно добавить список заблокированных пользователей
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 300),
                Text(
                  AppLocalizations.of(context)!.other,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(CupertinoIcons.person_add),
                  title: Text(AppLocalizations.of(context)!.inviteUsers),
                  onTap: () {
                    _copyToClipboard(context, 'https://example.com/download'); // Замените на реальную ссылку
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.headphones),
                  title: Text(AppLocalizations.of(context)!.technicalSupport),
                  onTap: () {
                    _launchURL('https://t.me/your_telegram_bot'); // Замените на реальную ссылку
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(AppLocalizations.of(context)!.productSourceCode),
                  onTap: () {
                    _launchURL('https://github.com/EgorSborschikov/comfort_confy');
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.person_2_fill),
                  title: Text(AppLocalizations.of(context)!.blockedUsersList),
                  onTap: () {
                    _showBlockedUsersList(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
