import 'package:comfort_confy/mobile/models/user_model/user_model.dart';
import 'package:comfort_confy/mobile/models/users_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import '../../server/services/search_services/search_user_service.dart';

class SearchUsersTextField extends StatefulWidget {
  final String nickname;

  const SearchUsersTextField({
    super.key,
    required this.nickname,
  });

  @override
  State<SearchUsersTextField> createState() => _SearchUsersTextFieldState();
}

class _SearchUsersTextFieldState extends State<SearchUsersTextField> {
  /*late TextEditingController _searchController;
  final SearchUserService _searchUserService = SearchUserService();
  List<User> _searchResults = []; // Список для хранения результатов поиска

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.nickname);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers() async {
    final String nicknameQuery = _searchController.text.trim();

    if (nicknameQuery.isEmpty) {
      // Обработайте ситуацию, если поле пустое.
      return;
    }

    try {
      final results = await _searchUserService.searchUsers(nicknameQuery);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print("Error occurred: $e");
      // Обработайте ошибку, если нужно
      setState(() {
        _searchResults = [];
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  placeholder: AppLocalizations.of(context)!.inputNicknameUser,
                  //controller: _searchController,
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},//_searchUsers,
                icon: const Icon(CupertinoIcons.search),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Отображение результатов поиска
          /*if (_searchResults.isNotEmpty) 
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index];
                  return UsersDataModel(nickname: user.nickname);
                },
              ),
            ),*/
        ],
      ),
    );
  }
}
