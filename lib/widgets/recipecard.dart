import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/screens/item.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String calories;
  final String time;
  final int id; 

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.calories,
    required this.time,
    required this.id,
    });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the container with GestureDetector
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(productId: widget.id),
          ),
        );
      }, // Use the onTap callback
      child: Container(
        width: 130,
        margin: const EdgeInsets.fromLTRB(
          8,
          16,
          8,
          16,
        ), // Add margin to allow shadow to be visible
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppDecorations.softShadow
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with like button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imagePath,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      );
                    },
                    // Add loading indicator
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return LoadingWidget();
                    },
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
      ),
    );
  }
}
