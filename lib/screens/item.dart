import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero, // Remove default padding
            constraints: BoxConstraints(), // Remove default size constraints
            icon: Image.asset(
              "assets/icons/heart.png",
              fit: BoxFit.cover, // Use contain to avoid cropping
              width: 90,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Full-screen background image
          Image.asset(
            "assets/img/popular1.png",
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Scrollable content with rounded corners
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 70,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3EBEC),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildRecipeHeader(),
                      _buildNutritionInfo(),
                      _buildTabSection(),
                      _buildIngredientsList(),
                      _buildAddToCartButton(),
                      _buildCreatorSection(),
                      _buildRelatedRecipes(context),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Healthy Taco Salad',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2533),
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    '15 Min',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'This Healthy Taco Salad is the ultimate delight of taco night! ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF748189)),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () {
                      // Handle view more tap
                    },
                    child: Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0A2533),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo() {
    final nutritionItems = [
      {'icon': "assets\\icons\\Carbs.png", 'value': '55g', 'label': 'carbs'},
      {
        'icon': "assets\\icons\\Proteins.png",
        'value': '27g',
        'label': 'proteins',
      },
      {'icon': "assets\\icons\\Calories.png", 'value': '120', 'label': 'kcal'},
      {'icon': "assets\\icons\\Fats.png", 'value': '9g', 'label': 'fats'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildNutritionItem(nutritionItems[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildNutritionItem(nutritionItems[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildNutritionItem(nutritionItems[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildNutritionItem(nutritionItems[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              item['icon'],
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${item['value']} ${item['label']}',
            style: const TextStyle(fontSize: 16, color: Color(0xFF0A2533)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(
            0xFFE3EBEC,
          ), // Light background for entire container
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          _selectedTabIndex == 0
                              ? const Color(0xFF042628)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            _selectedTabIndex == 0
                                ? Colors.white
                                : const Color(0xFF0A2533),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          _selectedTabIndex == 1
                              ? const Color(0xFF042628)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Instructions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            _selectedTabIndex == 1
                                ? Colors.white
                                : const Color(0xFF0A2533),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsList() {
    if (_selectedTabIndex == 0) {
      // Show ingredients content
      final ingredients = [
        {
          'name': 'Tortilla Chips',
          'quantity': '2',
          'icon': "assets\\icons\\Tortilla.png",
        },
        {
          'name': 'Avocado',
          'quantity': '1',
          'icon': "assets\\icons\\Avocado.png",
        },
        {
          'name': 'Red Cabbage',
          'quantity': '1',
          'icon': "assets\\icons\\RedCabbage.png",
        },
        {
          'name': 'Peanuts',
          'quantity': '1',
          'icon': "assets\\icons\\Peanuts.png",
        },
        {
          'name': 'Red Onions',
          'quantity': '1',
          'icon': "assets\\icons\\RedOnion.png",
        },
      ];

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Add All to Cart',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF70B9BE),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '5 items',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 12),
            ...ingredients.map(
              (ingredient) => _buildIngredientItem(ingredient),
            ),
          ],
        ),
      );
    } else {
      // Show instructions content
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            _buildInstructionStep(
              1,
              'Prepare all the vegetables by washing and chopping them into bite-sized pieces.',
            ),
            _buildInstructionStep(
              2,
              'In a large bowl, combine the chopped lettuce, tomatoes, and red onions.',
            ),
            _buildInstructionStep(
              3,
              'Add the cooked ground beef or turkey seasoned with taco seasoning.',
            ),
            _buildInstructionStep(
              4,
              'Top with sliced avocado, shredded cheese, and crushed tortilla chips.',
            ),
            _buildInstructionStep(
              5,
              'Drizzle with your favorite dressing and serve immediately.',
            ),
          ],
        ),
      );
    }
  }

  // Add a helper method for instruction steps
  Widget _buildInstructionStep(int number, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF70B9BE),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(fontSize: 16, color: Color(0xFF748189)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(Map<String, dynamic> ingredient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x0633361A).withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xFFe6ebf2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                ingredient['icon'],
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                ingredient['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A2533),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xFF70B9BE)),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: Color(0xFF70B9BE),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      ingredient['quantity']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xFF70B9BE)),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: Color(0xFF70B9BE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF70B9BE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Add To Cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Creator',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/natalia_luca.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Natalia Luca',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Food blogger and recipe developer',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedRecipes(BuildContext context) {
    final relatedRecipes = [
      {'title': 'Egg & Avo...', 'image': 'assets/images/recipe1.png'},
      {'title': 'Bowl of...', 'image': 'assets/images/recipe2.png'},
      {'title': 'Chicken S...', 'image': 'assets/images/recipe3.png'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Related Recipes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF70B9BE),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: relatedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = relatedRecipes[index];
                return Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          recipe['image']!,
                          height: 70,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recipe['title']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
