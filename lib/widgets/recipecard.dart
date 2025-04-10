import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String calories;
  final String time;

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.calories,
    required this.time,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.fromLTRB(
        8,
        16,
        0,
        16,
      ), // Add margin to allow shadow to be visible
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFFBFBFB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF063336).withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with like button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                8,
                8,
                8,
                5,
              ), // Adjust padding as needed
              child: Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Adjust the radius value as needed
                  child: Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A2533),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
