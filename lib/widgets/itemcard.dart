import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/screens/item.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String calories;
  final String time;
  final int id;
  final bool liked;
  final Function toggleLiked;

  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.calories,
    required this.time,
    required this.id,
    required this.liked,
    required this.toggleLiked,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the recipe detail screen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(productId: widget.id),
          ),
        );
      },
      child: Container(
        width: 220,
        height: 260,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppDecorations.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image:
                              Image.network(
                                widget.imagePath,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                                // Add loading indicator
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return LoadingWidget();
                                },
                              ).image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        widget.toggleLiked(widget.id);
                      },
                      child: Container(
                        child:
                            widget.liked
                                ? Image.asset(
                                  "assets/icons/heart_liked.png",
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.fill,
                                )
                                : Image.asset(
                                  "assets/icons/heart.png",
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.fill,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Info row with calories and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Calories
                      Image.asset(
                        "assets/icons/fire.png",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.calories,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.tertiary,
                        ),
                      ),
                      // Separator dot
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Time
                      Icon(
                        Icons.access_time,
                        size: 20,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "20 Min",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
