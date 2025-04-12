import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/models/product_model.dart';
import 'package:first_proj/providers/product_provider.dart';
import 'package:first_proj/screens/item.dart';
import 'package:first_proj/widgets/errorHandle.dart';
import 'package:first_proj/widgets/loading_widget.dart';
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
        SliverToBoxAdapter(child: MyFavoritesWidget()),
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

class MyFavoritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

        // If no liked products
        if (likedProducts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Favorites',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'No favorite recipes yet.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
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
                    'My Favorites',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                      fontSize: 18,
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
              itemCount: likedProducts.length,
              itemBuilder: (context, index) {
                final recipe = likedProducts[index];
                return _buildFavoriteItem(context, recipe, productProvider);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFavoriteItem(
    BuildContext context,
    Product product,
    ProductProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(productId: product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppDecorations.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fill,
                      height: 120,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        );
                      },
                      // Add loading indicator
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return LoadingWidget();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: GestureDetector(
                    onTap: () {
                      provider.toggleProductLike(product.id);
                    },
                    child: Image.asset(
                      "assets/icons/heart_liked.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: Text(
                product.title,
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
                        color: AppColors.tertiary.withAlpha(190),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
