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
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.blockedUsersList,
                    style: Theme.of(context).textTheme.titleMedium,
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
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _copyToClipboard(context, 'https://example.com/download'); // Замените на реальную ссылку
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Отступ между иконкой и текстом
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.inviteUsers),
                      ),
                      const Icon(CupertinoIcons.person_add),                      
                    ],
                  ),
                ),
                const Divider(), // Разделитель между элементами
                GestureDetector(
                  onTap: () {
                    _launchURL('https://t.me/your_telegram_bot'); // Замените на реальную ссылку
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
                      const Icon(Icons.code),
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    _showBlockedUsersList(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.blockedUsersList),
                      ),
                      const Icon(CupertinoIcons.stop_circle),                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
