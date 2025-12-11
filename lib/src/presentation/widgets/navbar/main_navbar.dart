import 'package:aurea_app/src/presentation/widgets/navbar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  static const double _navbarHeight = 80.0;
  static const double _iconSize = 30.0;

  @override
  void initState() {
    super.initState();
    selectedRoute = widget.selectedRoute;
    _updateIndexFromRoute(selectedRoute);
  }

  void _updateIndexFromRoute(String route) {
    setState(() {
      initialIndex =
          route == "/home"
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
    void handleTap(int index) {
      widget.onItemSelected?.call(index);
    }

    final mediaQueryData = MediaQuery.of(context);
    final bottomPadding = mediaQueryData.padding.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        double size = _iconSize;
        if (constraints.maxHeight < 410) {
          size = constraints.maxWidth * 0.0975;
        }
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding / 4, left: 30),
          child: NavBarButton(
            index: initialIndex,
            height: _navbarHeight,
            color: Theme.of(context).colorScheme.secondary,
            onTap: (value) => handleTap(value),
            items: [
              SvgPicture.asset(
                'assets/icons/home.svg',
                width: size,
                height: size,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              Icon(
                Icons.contact_support_outlined,
                size: size,
                color: Colors.white,
              ),
              Icon(Icons.person, size: size, color: Colors.white),
              Icon(Icons.settings_outlined, size: size, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
