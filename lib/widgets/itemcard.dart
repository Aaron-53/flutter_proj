import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/screens/item.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? calories;
  final int id;
  final bool liked;
  final Function toggleLiked;
  final bool author;
  final bool details;
  final bool showLiked;
  final int textLines; 
  final double titleSize;
  final double titleHeight;

  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.calories,
    required this.id,
    this.liked = false,
    this.toggleLiked = placeholder,
    this.author = false,
    this.details = true,
    this.showLiked = true,
    this.textLines = 2,
    this.titleSize = 18,
    this.titleHeight = 1.2,
  });

  static void placeholder() {}

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
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppDecorations.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.lerp(BorderRadius.circular(12), BorderRadius.circular(0), 0.0)!,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Image.network(
                        widget.imagePath,
                        fit: BoxFit.contain, 
                        width: double.infinity, 
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          );
                        },
                         loadingBuilder: (context, child, loadingProgress) {
                           if (loadingProgress == null) return child;
                           return const LoadingWidget();
                        },
                      ),
                    ),
                  ),
                  if (widget.showLiked)
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
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.titleSize,
                      height: widget.titleHeight,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    maxLines: widget.textLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: widget.details ? 8 : 0),
                  if (widget.details)
                    widget.author
                        ? Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              radius: 16,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/people/featured1.png',
                                ),
                                radius: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'random guy',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.tertiary,
                              ),
                            ),
                          ],
                        )
                        : Row(
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
                              widget.calories ?? "value not found",
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
