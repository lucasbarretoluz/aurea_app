import 'package:aurea_app/src/presentation/widgets/app_bar/aurea_app_bar.dart';
import 'package:aurea_app/src/presentation/widgets/navbar/main_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageView();
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String selectedRoute = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AureaAppBar(),
      body: Center(child: Text('Home Page')),
      bottomNavigationBar: MainNavbar(
        selectedRoute: selectedRoute,
        onItemSelected: (index) {
          switch (index) {
            case 0:
              setState(() {
                selectedRoute = "/home";
              });
              break;
            case 1:
              context.push('/profile');
              break;
            case 2:
              setState(() {
                selectedRoute = "/help";
              });
              break;
            case 3:
              setState(() {
                selectedRoute = "/login";
              });
              break;
          }
        },
      ),
    );
  }
}
