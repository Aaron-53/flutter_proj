import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const Categories({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              onPressed: () => onCategorySelected(index),
              style: TextButton.styleFrom(
                backgroundColor:
                    isSelected
                        ? const Color(0xFF70B9BE)
                        : const Color(0xFFF1F5F5),
                foregroundColor:
                    isSelected ? Colors.white : const Color(0xFF0A2533),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(categories[index], style: TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
