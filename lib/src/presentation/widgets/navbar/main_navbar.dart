import 'package:aurea_app/src/presentation/widgets/navbar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavbar extends StatefulWidget {
  final String selectedRoute;
  final Function(int)? onItemSelected;

  const MainNavbar({
    super.key,
    required this.selectedRoute,
    this.onItemSelected,
  });

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  late String selectedRoute;
  int initialIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedRoute = widget.selectedRoute;
    _updateIndexFromRoute(selectedRoute);
  }

  void _updateIndexFromRoute(String route) {
    setState(() {
      initialIndex = route == "/home"
          ? 0
          : route == "/profile"
              ? 1
              : route == "/help"
                  ? 2
                  : 3;
    });
  }

  @override
  void didUpdateWidget(covariant MainNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedRoute != widget.selectedRoute) {
      setState(() {
        selectedRoute = widget.selectedRoute;
        _updateIndexFromRoute(selectedRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void _handleTap(int index) {
      widget.onItemSelected?.call(index);
      
      switch (index) {
        case 0:
          if (selectedRoute != "/home") {
            context.go('/home');
          }
          break;
        case 1:
          if (selectedRoute != "/profile") {
            context.go('/profile');
          }
          break;
        case 2:
          if (selectedRoute != "/help") {
            context.go('/help');
          }
          break;
        case 3:
          context.go('/login');
          break;
      }
    }

    final mediaQueryData = MediaQuery.of(context);
    final bottomPadding = mediaQueryData.padding.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        double size = 40;
        if (constraints.maxHeight < 410) {
          size = constraints.maxWidth * 0.0975;
        }
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding / 4),
          child: EMVButtonBar(
            index: initialIndex,
            height: 65,
            color: const Color(0xFFF5F5F5),
            onTap: (value) => _handleTap(value),
            items: [
              Icon(
                Icons.home,
                size: selectedRoute == "/home" ? size - 10 : size,
                color: selectedRoute == "/home"
                    ? Colors.black
                    : const Color(0xFF9E9E9E),
              ),
              Icon(
                Icons.person,
                size: selectedRoute == "/profile" ? size - 10 : size,
                color: selectedRoute == "/profile"
                    ? Colors.black
                    : const Color(0xFF9E9E9E),
              ),
              Icon(
                Icons.help_outline,
                size: selectedRoute == "/help" ? size - 10 : size,
                color: selectedRoute == "/help"
                    ? Colors.black
                    : const Color(0xFF9E9E9E),
              ),
              Icon(
                Icons.exit_to_app,
                size: size - 10,
                color: const Color(0xFF9E9E9E),
              ),
            ],
          ),
        );
      },
    );
  }
}
