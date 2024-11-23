import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class SearchUsersTextFiled extends StatefulWidget{
  final String nickname;

  const SearchUsersTextFiled({
      super.key, 
      required this.nickname,
    }
  ); 

  @override
  State<SearchUsersTextFiled> createState() => _SearchUsersTextFiledState();
}

class _SearchUsersTextFiledState extends State<SearchUsersTextFiled> {
  late TextEditingController _search_controller;

  @override
  void initState() {
    super.initState();
    _search_controller = TextEditingController(text: widget.nickname);
  }

  @override
  void dispose(){
    _search_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              placeholder: AppLocalizations.of(context)!.inputNicknameUser,
              controller: _search_controller,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {

            }, 
            icon: const Icon(CupertinoIcons.search)
          ),
        ],
      ),
    );
  }
}