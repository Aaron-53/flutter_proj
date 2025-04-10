import 'package:first_proj/widgets/category.dart';
import 'package:first_proj/widgets/featuredbox.dart';
import 'package:first_proj/widgets/itemcard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String username;

  const Home({super.key, required this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedCategoryIndex = 0;

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildGreetingBox(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 20),
          sliver: SliverToBoxAdapter(
            child: _buildFeaturedSection(context),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 20),
          sliver: SliverToBoxAdapter(
            child: _buildCategoriesSection(context),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 20),
          sliver: _buildPopularRecipesSection(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 70),
        ),
      ],
    );
  }

  Widget _buildGreetingBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/Sun.png",
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Good Morning,',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0A2533),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    widget.username,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color(0xFF0A2533),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Image.asset(
                "assets/icons/Cart.png",
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              onPressed: () {
                // Cart action
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context) {
    final List<Map<String, String>> featuredRecipes = [
      {
        'imagePath': 'assets\\img\\featured_bg1.png',
        'title': 'Asian white noodle with extra seafood',
        'authorImage': 'assets\\people\\featured1.png',
        'authorName': 'James Spader',
        'time': '20 Min',
      },
      {
        'imagePath': 'assets\\img\\featured_bg2.png',
        'title': 'Healthy Taco Salad with fresh vegetable',
        'authorImage': 'assets\\people\\featured2.png',
        'authorName': 'Olivia Rizka',
        'time': '12 Min',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Featured',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: featuredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = featuredRecipes[index];
              return FeaturedBox(
                imagePath: recipe['imagePath']!,
                title: recipe['title']!,
                authorImage: recipe['authorImage']!,
                authorName: recipe['authorName']!,
                time: recipe['time']!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final categories = [
      'All',
      'Breakfast',
      'Lunch',
      'Dinner',
      'Desserts',
      'Snacks',
      'Drinks',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Category',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Categories(
          categories: categories,
          selectedIndex: _selectedCategoryIndex,
          onCategorySelected: _onCategorySelected,
        ),
      ],
    );
  }

  Widget _buildPopularRecipesSection(BuildContext context) {
    final List<Map<String, String>> popularRecipes = [
      {
        'imagePath': 'assets\\img\\popular1.png',
        'title': 'Healthy Taco Salad with fresh vegetable',
        'calories': '320 kcal',
        'time': '20Min',
      },
      {
        'imagePath': 'assets\\img\\popular2.png',
        'title': 'Healthy Taco Salad with fresh vegetable',
        'calories': '280 kcal',
        'time': '12 Min',
      },
      {
        'imagePath': 'assets\\img\\popular1.png',
        'title': 'Grilled Salmon with Vegetables',
        'calories': '420 kcal',
        'time': '25 min',
      },
      {
        'imagePath': 'assets\\img\\popular2.png',
        'title': 'Avocado Toast with Eggs',
        'calories': '210 kcal',
        'time': '10 min',
      },
      {
        'imagePath': 'assets\\img\\popular1.png',
        'title': 'Berry Smoothie Bowl',
        'calories': '180 kcal',
        'time': '5 min',
      },
    ];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Popular Recipes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 332,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: popularRecipes.length,
              itemBuilder: (context, index) {
                final recipe = popularRecipes[index];
                return ItemCard(
                  imagePath: recipe['imagePath']!,
                  title: recipe['title']!,
                  calories: recipe['calories']!,
                  time: recipe['time']!,
                  onTap: () {
                    print('Tapped on ${recipe['title']}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
