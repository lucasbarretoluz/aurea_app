import 'package:aurea_app/src/presentation/screens/home/home_page.dart';
import 'package:aurea_app/src/presentation/widgets/app_bar/aurea_app_bar.dart';
import 'package:aurea_app/src/presentation/widgets/navbar/main_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfigHomePage extends StatelessWidget {
  const ConfigHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigHomePageView();
  }
}

class ConfigHomePageView extends StatefulWidget {
  const ConfigHomePageView({super.key});

  @override
  State<ConfigHomePageView> createState() => _ConfigHomePageViewState();
}

class _ConfigHomePageViewState extends State<ConfigHomePageView> {
  static const String selectedRoute = "/home";

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] ⚪ ConfigHomePage build - selectedRoute: $selectedRoute');
    return Scaffold(
      appBar: AureaAppBar(),
      body: HomePage(),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: MainNavbar(
          selectedRoute: selectedRoute,
          onItemSelected: (index) {
            print('[DEBUG] 🟣 onItemSelected chamado - index: $index');
            switch (index) {
              case 0:
                print('[DEBUG] 🟣 case 0 - Home');
                break;
              case 1:
                print('[DEBUG] 🟣 case 1 - Navegando para /support');
                context.push('/support');
                break;
              case 2:
                print('[DEBUG] 🟣 case 2 - Navegando para /profile');
                context.push('/profile');
                break;
              case 3:
                print('[DEBUG] 🟣 case 3 - Navegando para /settings');
                context.push('/settings');
                break;
            }
          },
        ),
      ),
    );
  }
}
