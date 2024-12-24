import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsModel extends StatefulWidget {
  final String nickname;
  final String information;
  final String workingHours;
  final bool isOnline;
  final String lastSeen;

  const ProfileSettingsModel({
    super.key,
    required this.nickname,
    this.information = '',
    this.workingHours = '',
    this.lastSeen = '', 
    required this.isOnline, 
  });

  @override
  State<ProfileSettingsModel> createState() => _ProfileSettingsModelState();
}

class _ProfileSettingsModelState extends State<ProfileSettingsModel> {
  late TextEditingController _nicknameController;
  late TextEditingController _informationController;

  bool _isEditingNickname = false; // переменная для отслеживания состояния редактирования
  bool _isEditingInformation = false; 

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.nickname);
    _informationController = TextEditingController(text: widget.information);
  }

  @override
  void dispose(){
    _nicknameController.dispose();
    _informationController.dispose();
    super.dispose();
  }

  Future<void> _saveNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _nicknameController.text);
  }

  Future<void> _saveInformation() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    await prefs.setString('information', _informationController.text);
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); 

    if (image != null) {
      setState(() {
        _imagePath = image.path; // Обновляем путь к изображению
      });
    }
  }

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
               Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary,// Цвет фона для контейнера
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary, 
                        width: 2.0
                      ), // Обводка
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      radius: 50.0,
                      backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                      child: _imagePath == null
                          ? const Icon(
                              CupertinoIcons.person, 
                              size: 50,
                              color: Color(0xFF5727EC),
                            )
                          : null,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.add_circled, size: 30),
                    color: Color(0xFF5727EC),
                    onPressed: _selectImage,
                  ),
                ],
              ),
              const SizedBox(height: 40),
                Text(
                  '${AppLocalizations.of(context)!.workingHours}:',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: const Color(0xFF5727EC),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.workingHours,
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
                  widget.isOnline ? Icons.circle : Icons.circle_outlined,
                  color: widget.isOnline ? Colors.green : Colors.grey,
                  size: 10.0,
                ),
                const SizedBox(height: 4.0),
                Text(
                  widget.isOnline ? AppLocalizations.of(context)!.online : widget.lastSeen,
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
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        controller: _nicknameController, // Используем контроллер
                        enabled: _isEditingNickname,
                        //placeholder: $nickname, // Плейсхолдер
                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                        onSubmitted: (_) => _saveNickname(), // Сохраняем никнейм при нажатии Enter
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEditingNickname = !_isEditingNickname; // Переключаем состояние редактирования
                        });
                      },
                      icon: Icon(_isEditingNickname ? CupertinoIcons.check_mark : CupertinoIcons.pen), // Изменяем иконку в зависимости от состояния
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.information}:',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        controller: _informationController, // Используем контроллер
                        enabled: _isEditingInformation,
                        //placeholder: $nickname, // Плейсхолдер
                        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                        onSubmitted: (_) => _saveInformation(), // Сохраняем никнейм при нажатии Enter
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEditingInformation = !_isEditingInformation; // Переключаем состояние редактирования
                        });
                      },
                      icon: Icon(_isEditingInformation ? CupertinoIcons.check_mark : CupertinoIcons.pen), // Изменяем иконку в зависимости от состояния
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.information,
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
