import 'package:first_proj/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';
import '../widgets/recipecard.dart';

class RelatedProducts extends StatefulWidget {
  final int currentProductId;

  const RelatedProducts({Key? key, required this.currentProductId})
    : super(key: key);

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  List<Product> _relatedProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedProducts();
  }

  Future<void> _loadRelatedProducts() async {
    try {
      // Fetch all products
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      await productProvider.fetchProducts();

      // Filter out the current product and limit to 5 products
      setState(() {
        _relatedProducts =
            productProvider.products
                .where((product) => product.id != widget.currentProductId)
                .take(5)
                .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no related products are available, use sample data
    if (_relatedProducts.isEmpty && !_isLoading) {
      return _buildWithSampleData(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Related Products',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: _relatedProducts.length,
                itemBuilder: (context, index) {
                  final product = _relatedProducts[index];
                  return RecipeCard(
                    imagePath: product.image,
                    title: product.title,
                    calories: '${product.price.toStringAsFixed(2)}',
                    time: product.category,
                    id: product.id,
                  );
                },
              ),
            ),
      ],
    );
  }

  // Fallback method to use sample data if API data isn't available
  Widget _buildWithSampleData(BuildContext context) {
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
                  color: AppColors.secondary,
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
                id: index, 
              );
            },
          ),
        ),
      ],
    );
  }
}
