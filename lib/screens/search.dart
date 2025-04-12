import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/models/product_model.dart';
import 'package:first_proj/providers/selectedindexprovider.dart';
import 'package:first_proj/widgets/category.dart';
import 'package:first_proj/widgets/editorschoice.dart';
import 'package:first_proj/widgets/errorHandle.dart';
import 'package:first_proj/widgets/recipecard.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch products and categories when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      productProvider.fetchProducts();
      productProvider.fetchCategories();
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });

    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final categories = productProvider.categories;

    if (index > 0) {
      productProvider.fetchProductsByCategory(categories[index].toLowerCase());
    } else {
      productProvider.fetchProducts();
    }
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBox(context),
        _buildCategoriesSection(context),
        SizedBox(height: 20),
        // Scrollable content
        Expanded(
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              if (productProvider.isLoading) {
                return LoadingWidget(message: 'Loading products...');
              }

              if (productProvider.error.isNotEmpty) {
                return ErrorDisplayWidget();
              }

              final products = productProvider.products;

              // Filter products based on search query
              final filteredProducts =
                  _searchQuery.isEmpty
                      ? products
                      : products
                          .where(
                            (product) =>
                                product.title.toLowerCase().contains(
                                  _searchQuery,
                                ) ||
                                product.description.toLowerCase().contains(
                                  _searchQuery,
                                ) ||
                                product.category.toLowerCase().contains(
                                  _searchQuery,
                                ),
                          )
                          .toList();

              if (filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    _searchQuery.isEmpty
                        ? 'No products available'
                        : 'No products matching "$_searchQuery"',
                    style: TextStyle(fontSize: 16, color: Color(0xFF748189)),
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 20),
                    sliver: SliverToBoxAdapter(
                      child: _buildProductsSection(context, filteredProducts),
                    ),
                  ),
                  SliverToBoxAdapter(child: const SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Editor\'s Choice',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'View All',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  _buildEditorsChoiceSection(context, filteredProducts),
                  SliverToBoxAdapter(child: const SizedBox(height: 80)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    final provider = Provider.of<SelectedIndexProvider>(context, listen: false);

    return Column(
      children: [
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 24,
                ),
                onPressed: () {
                  provider.updateIndex(0);
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
              TextStyle(fontSize: 20, color: AppColors.tertiary),
            ),
            leading: Image.asset("assets/icons/Search_dark.png"),
            backgroundColor: WidgetStateColor.resolveWith(
              (states) => Colors.transparent,
            ),
            side: WidgetStateProperty.all(
              BorderSide(color: Color(0xFFE6EBF2), width: 3),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            shadowColor: WidgetStateColor.resolveWith(
              (states) => Colors.transparent,
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: _onSearch,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final categories = productProvider.categories;

        if (productProvider.isLoading) {
          return LoadingWidget(message: 'Loading categories...');
        }

        if (productProvider.error.isNotEmpty) {
          return Center(child: Text('Error: ${productProvider.error}'));
        }

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
      },
    );
  }

  Widget _buildProductsSection(BuildContext context, List<Product> products) {
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
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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

  Widget _buildEditorsChoiceSection(
    BuildContext context,
    List<Product> products,
  ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = products[index];
        return EditorChoiceCard(
          id: product.id,
          imagePath: product.image,
          title: product.title,
          authorImage: 'assets/people/featured${index % 2 + 1}.png',
          authorName: 'Author ${index + 1}',
          rightName: '\$${product.price.toStringAsFixed(2)}',
        );
      }, childCount: products.length),
    );
  }
}
