import 'package:auto_route/auto_route.dart';
import 'package:comfort_confy/features/conference/view/conference_page.dart';
import 'package:comfort_confy/features/conference_history/view/conference_history_page.dart';
import '../features/conference_search/view/conference_search_page.dart';
import '../features/home/view/home_page.dart';
import '../features/login/view/login_page.dart';
import '../features/register/view/register_page.dart';
import '../features/settings/view/settings_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(page: ConferenceHistoryRoute.page, path: 'history'),
        AutoRoute(page: ConferenceSearchRoute.page, path: 'search'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
        AutoRoute(page: ConferenceRoute.page, path: 'conference'),
      ],
    ),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
  ];
}