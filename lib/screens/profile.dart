import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildAccountHeader(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: MyFavoritesWidget(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 85),
        ),
      ],
    );
  }

  Widget _buildAccountHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Color(0xFF0A2533)),
                onPressed: () {
                  // Handle settings action
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF97A2B0),
                radius: 30,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/people/featured2.png"),
                  radius: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alena Sabyan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Recipe Developer',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/icons/Right_arrow.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                onPressed: () {
                  // Handle navigation action
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyFavoritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> favorites = [
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Sunny Egg & Toast Avocado',
        'authorName': 'Alice Fala',
        'authorImage': 'assets/people/featured1.png',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Bowl of noodle with beef',
        'authorName': 'James Spader',
        'authorImage': 'assets/people/featured2.png',
      },
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Easy homemade beef burger',
        'authorName': 'Agnes',
        'authorImage': 'assets/people/featured1.png',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Half boiled egg sandwich',
        'authorName': 'Natalia Luca',
        'authorImage': 'assets/people/featured2.png',
      },
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Easy homemade beef burger',
        'authorName': 'Agnes',
        'authorImage': 'assets/people/featured1.png',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Half boiled egg sandwich',
        'authorName': 'Natalia Luca',
        'authorImage': 'assets/people/featured2.png',
      },
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Easy homemade beef burger',
        'authorName': 'Agnes',
        'authorImage': 'assets/people/featured1.png',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Half boiled egg sandwich',
        'authorName': 'Natalia Luca',
        'authorImage': 'assets/people/featured2.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Favorites',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF70B9BE),
                  fontSize: 18
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 4,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final recipe = favorites[index];
            return _buildFavoriteItem(context, recipe);
          },
        ),
      ],
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Map<String, String> recipe) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x0633361A).withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    recipe['imagePath']!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Image.asset(
                  "assets/icons/heart_liked.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 6,
            ),
            child: Text(
              recipe['title']!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF97A2B0),
                    radius: 16,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        recipe['authorImage'] ?? '',
                      ),
                      radius: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    recipe['authorName'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF97A2B0).withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
