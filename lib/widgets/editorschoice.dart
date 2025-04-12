import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/screens/item.dart';
import 'package:first_proj/widgets/loading_widget.dart';
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
          boxShadow: AppDecorations.softShadow,
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
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.tertiary,
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
                            color: AppColors.tertiary.withValues(alpha: 0.75),
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
