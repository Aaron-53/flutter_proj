import 'package:first_proj/widgets/category.dart';
import 'package:first_proj/widgets/recipecard.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int _selectedCategoryIndex = 0;

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF0A2533),
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              "Search",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: SearchBar(
            hintText: ' Search',
            textStyle: WidgetStateProperty.all(
              TextStyle(fontSize: 20, color: Color(0xFF97A2B0)),
            ),
            leading: Image.asset("assets/icons/Search_dark.png"),
            backgroundColor: WidgetStateColor.transparent,
            side: WidgetStateProperty.all(
              BorderSide(color: Color(0xFFE6EBF2), width: 3),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            shadowColor: WidgetStateColor.transparent,
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: (value) {
              // handle search input
            },
          ),
        ),
        _buildCategoriesSection(context),
        SizedBox(height: 20), // Add spacing
        _buildPopularRecipesSection(context), // Add the new section
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
        'imagePath': 'assets/img/popular1.png',
        'title': 'Healthy Taco Salad with fresh vegetable',
        'calories': '320 kcal',
        'time': '20 Min',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Healthy Taco Salad with fresh vegetable',
        'calories': '280 kcal',
        'time': '12 Min',
      },
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Grilled Salmon with Vegetables',
        'calories': '420 kcal',
        'time': '25 min',
      },
      {
        'imagePath': 'assets/img/popular2.png',
        'title': 'Avocado Toast with Eggs',
        'calories': '210 kcal',
        'time': '10 min',
      },
      {
        'imagePath': 'assets/img/popular1.png',
        'title': 'Berry Smoothie Bowl',
        'calories': '180 kcal',
        'time': '5 min',
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
                'Popular Recipes',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF70B9BE),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: popularRecipes.length,
            itemBuilder: (context, index) {
              final recipe = popularRecipes[index];
              return RecipeCard(
                imagePath: recipe['imagePath']!,
                title: recipe['title']!,
                calories: recipe['calories']!,
                time: recipe['time']!,
              );
            },
          ),
        ),
      ],
    );
  }
}
