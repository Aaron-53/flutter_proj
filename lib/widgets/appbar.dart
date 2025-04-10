import 'package:first_proj/provider/selectedindexprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  // List of icon paths for unselected state
  final List<String> _unselectedIcons = [
    'assets/icons/Home_unselected.png',
    'assets/icons/Search_unselected.png',
    'assets/icons/Notification_unselected.png',
    'assets/icons/Profile_unselected.png',
  ];

  // List of icon paths for selected state
  final List<String> _selectedIcons = [
    'assets/icons/Home_selected.png',
    'assets/icons/Search_selected.png',
    'assets/icons/Notification.png',
    'assets/icons/Profile_selected.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedIndexProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomAppBar(
              notchMargin: 10.0,
              shape: CircularNotchedRectangle(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(context, 0),
                        _buildIconButton(context, 1),
                      ],
                    ),
                  ),
                  SizedBox(width: 80),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconButton(context, 2),
                        _buildIconButton(context, 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconButton(BuildContext context, int index) {
    final provider = Provider.of<SelectedIndexProvider>(context, listen: false);
    final selectedIndex = provider.selectedIndex;

    return IconButton(
      icon: Image.asset(
        selectedIndex == index
            ? _selectedIcons[index]
            : _unselectedIcons[index],
        width: 24,
        height: 24,
      ),
      onPressed: () => provider.updateIndex(index),
    );
  }
}
