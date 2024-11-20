import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileSettingsModel extends StatelessWidget {
  final String nickname;
  final String information;
  final String workingHours;
  final bool isOnline;
  final String lastSeen;

  const ProfileSettingsModel({
    super.key,
    required this.nickname,
    required this.information,
    required this.workingHours,
    required this.isOnline,
    required this.lastSeen,
  });

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
          Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                // Replace with your image path
              ),
              const SizedBox(height: 60),
                Text(
                  '${AppLocalizations.of(context)!.workingHours}:',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: const Color(0xFF5727EC),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                workingHours,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Icon(
                  isOnline ? Icons.circle : Icons.circle_outlined,
                  color: isOnline ? Colors.green : Colors.grey,
                  size: 10.0,
                ),
                const SizedBox(height: 4.0),
                Text(
                  isOnline ? AppLocalizations.of(context)!.online : lastSeen,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.nickname}:',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.information}:',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  information,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
