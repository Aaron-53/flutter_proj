import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/models/product_model.dart';
import 'package:first_proj/providers/product_provider.dart';
import 'package:first_proj/widgets/errorHandle.dart';
import 'package:first_proj/widgets/itemcard.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:first_proj/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.username});
  final String username;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

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
        SliverToBoxAdapter(child: _buildFavouritesSection(context)),
        SliverToBoxAdapter(child: SizedBox(height: 85)),
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
            boxShadow: AppDecorations.softShadow,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.tertiary,
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
                      widget.username,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Recipe Developer',
                      style: TextStyle(color: AppColors.tertiary, fontSize: 14),
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

Widget _buildFavouritesSection(BuildContext context) {
  return Consumer<ProductProvider>(
    builder: (context, productProvider, child) {
      // Filter products that are liked
      List<Product> likedProducts =
          productProvider.products.where((product) => product.liked).toList();

      // If no products are loaded yet or there's an error, handle it
      if (productProvider.isLoading) {
        return Center(child: LoadingWidget(message: "Loading..."));
      }

      if (productProvider.error.isNotEmpty) {
        return ErrorDisplayWidget();
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SectionTitle(title: "My Favorites", actionText: "See All"),
            SizedBox(height: 20),
            if (likedProducts.isEmpty)
              Center(
                child: Text(
                  'No favorite recipes yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 26 / 33,
                ),
                itemCount: likedProducts.length,
                itemBuilder: (context, index) {
                  final recipe = likedProducts[index];
                  return ItemCard(
                    imagePath: recipe.image,
                    title: recipe.title,
                    calories: recipe.price.toStringAsFixed(2),
                    id: recipe.id,
                    liked: recipe.liked,
                    toggleLiked: productProvider.toggleProductLike,
                    author: true,
                    titleSize: 16,
                  );
                },
              ),
          ],
        ),
      );
    },
  );
}
