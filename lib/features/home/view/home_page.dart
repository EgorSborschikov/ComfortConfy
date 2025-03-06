import 'package:auto_route/auto_route.dart';
import 'package:comfort_confy/components/platform/platform_bottom_navigation_bar.dart';
import 'package:comfort_confy/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HomePage extends StatelessWidget{
  const HomePage({super.key});
  
  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
    final tabRoutes = tabsRouter.routeCollection.routes.toList();
    final path = tabRoutes[index].path;
    //Analytics.i.logScreenView('/$path');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  AutoTabsRouter(
      routes: [
        ConferenceHistoryRoute(),
        ConferenceSearchRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: PlatformBottomNavigationBar(
            tabsRouter: tabsRouter, 
            onSelect: (index) => _openPage(index, tabsRouter),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.phone,
                ),
                label: AppLocalizations.of(context)!.callHistory,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.search,
                ),
                label: AppLocalizations.of(context)!.search,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.settings_solid,
                ),
                label: AppLocalizations.of(context)!.settings,
              ),
            ]
          ),
        );
      },
    );
  }
}