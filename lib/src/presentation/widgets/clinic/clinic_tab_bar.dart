import 'package:flutter/material.dart';

class ClinicTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
  final Function(int)? onTabLongPress;
  final VoidCallback? onAddPressed;

  const ClinicTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.onTabLongPress,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  tabs.length,
                  (index) => GestureDetector(
                    onTap: () => onTabSelected(index),
                    onLongPress:
                        onTabLongPress != null
                            ? () => onTabLongPress!(index)
                            : null,
                    child: Container(
                      margin: const EdgeInsets.only(right: 24),
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: selectedIndex == index
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

