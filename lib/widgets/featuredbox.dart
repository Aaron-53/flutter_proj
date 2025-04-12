import 'package:flutter/material.dart';

class FeaturedBox extends StatelessWidget {
  final String imagePath;
  final String title;
  final String authorImage;
  final String authorName;
  final String time;

  const FeaturedBox({
    super.key,
    required this.imagePath,
    required this.title,
    required this.authorImage,
    required this.authorName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150, 
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Colors.white, // This creates the white border
                  radius: 13, // Slightly larger than the inner avatar
                  child: CircleAvatar(
                    backgroundImage: AssetImage(authorImage),
                    radius: 12,
                  ),
                ),

                const SizedBox(width: 8),
                Text(
                  authorName,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 14,
                  ),
                ),

                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
