import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String calories;
  final String time;
  final Function()? onTap;

  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.calories,
    required this.time,
    this.onTap,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with like button
          Stack(
            children: [
              // Image container
              Padding(
                padding: const EdgeInsets.all(12.0), // Adjust padding as needed
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Change to all corners
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Like button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                  child: Container(
                    child:
                        _isLiked
                            ? Image.asset("assets/icons/heart_liked.png")
                            : Image.asset("assets/icons/heart.png"),
                  ),
                ),
              ),
            ],
          ),
          // Content section
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
                    color: Color(0xFF0A2533),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Info row with calories and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Calories
                    Image.asset(
                      "assets/icons/fire.png",
                      width: 16,
                      height: 16,
                      color: const Color(0xFF97A2B0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.calories,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFF97A2B0),
                      ),
                    ),
                    // Separator dot
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFF97A2B0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Time
                    Icon(
                      Icons.access_time,
                      size: 20,
                      color: Color(0xFF97A2B0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.time,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF97A2B0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
