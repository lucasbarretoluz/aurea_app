import 'package:aurea_app/src/presentation/screens/home/home_page.dart';
import 'package:aurea_app/src/presentation/widgets/app_bar/aurea_app_bar.dart';
import 'package:aurea_app/src/presentation/widgets/help_center/help_center_drawer.dart';
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

  void _openHelpCenter() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => const HelpCenterDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AureaAppBar(),
      body: HomePage(),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: MainNavbar(
          selectedRoute: selectedRoute,
          onItemSelected: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                _openHelpCenter();
                break;
              case 2:
                context.push('/profile');
                break;
              case 3:
                context.push('/settings');
                break;
            }
          },
        ),
      ),
    );
  }
}
