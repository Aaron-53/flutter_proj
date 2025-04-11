import 'package:first_proj/screens/item.dart';
import 'package:flutter/material.dart';

class EditorChoiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String authorImage;
  final String authorName;
  final String rightName;
  final int id; 

  const EditorChoiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.authorImage,
    required this.authorName,
    required this.rightName,
    required this.id, 
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(productId: id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF063336).withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image section
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Text section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A2533),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(
                            0xFF97A2B0,
                          ), // This creates the white border
                          radius: 14, // Slightly larger than the inner avatar
                          child: CircleAvatar(
                            backgroundImage: AssetImage(authorImage),
                            radius: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          authorName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF97A2B0).withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Right name
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Image.asset("assets\\icons\\Right_arrow.png"),
            ),
          ],
        ),
      ),
    );
  }
}
