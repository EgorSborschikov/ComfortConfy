import 'package:comfort_confy/mobile/components/bars/app_bars/general/general_app_bar.dart';
import 'package:comfort_confy/mobile/models/users_data_model.dart';
import 'package:comfort_confy/services/search_service/search_user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchUsersPage extends StatefulWidget {
  const SearchUsersPage({super.key});

  @override
  State<SearchUsersPage> createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final SearchUserService _searchService = SearchUserService();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isShowAlert = false;

  Future<void> _searchUsers(String nickname) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final users = await _searchService.searchUsers(nickname);
      setState(() {
        _isLoading = false;
      });
      // Handle the users data
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: AppLocalizations.of(context)!.search,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _searchController,
                      placeholder: AppLocalizations.of(context)!.inputNicknameUser,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.inactiveGray),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(CupertinoIcons.search),
                    onPressed: () {
                      _searchUsers(_searchController.text);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.searchResult,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              const Divider(),
              Expanded(
                child: _isLoading
                    ? const Center(child: 
                    CupertinoActivityIndicator(
                      radius: 20.0, 
                      color: Color(0xFF5727EC),
                    ))
                    : FutureBuilder<List<dynamic>>(
                        future: _searchService.searchUsers(_searchController.text),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(child: 
                                CupertinoActivityIndicator(
                                  radius: 20.0, 
                                  color: Color(0xFF5727EC),
                                )
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text(AppLocalizations.of(context)!.noUsersFound));
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final user = snapshot.data![index];
                                    return Column(
                                      children: [
                                        UsersDataModel(
                                          nickname: user['nickname'],
                                          profilePicture: user['profilePicture'] ?? '', 
                                        ),
                                        //const SizedBox(height: 10), // Отступ между модельками пользователей
                                      ],
                                    );
                                  },
                                );
                              }
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}