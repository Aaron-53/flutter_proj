import 'package:first_proj/main.dart';
import 'package:first_proj/models/product_model.dart';
import 'package:first_proj/widgets/errorHandle.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:first_proj/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/ingredients_list.dart';
import '../widgets/related_products.dart';
import '../constants/constants.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int productId;

  const RecipeDetailScreen({super.key, required this.productId});

  @override
  State createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _selectedTabIndex = 0;
  bool _expandedDescription = false;

  void onClose() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (productProvider.currentId != widget.productId) {
        productProvider.fetchProductById(widget.productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.isLoading) {
          return Scaffold(body: Center(child: LoadingWidget()));
        }

        final product = productProvider.fetchProductById(widget.productId);

        if (productProvider.error.isNotEmpty) {
          return Scaffold(body: ErrorDisplayWidget());
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(product),
          body: Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.white)),
              Image.network(
                product.image,
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.error, color: Colors.red)),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return LoadingWidget();
                },
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      boxShadow: AppDecorations.softShadow,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          _buildDragHandle(),
                          SizedBox(height: 20),
                          _buildProductHeader(product),
                          _buildProductInfo(product),
                          _buildTabSection(),
                          _selectedTabIndex == 0
                              ? IngredientsList(product: product)
                              : _buildDetailsSection(product),
                          _buildAddToCartButton(),
                          _buildCreatorSection(),
                          RelatedProducts(currentProductId: product.id),
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
      },
    );
  }

  // UI Component Methods

  PreferredSizeWidget _buildAppBar(Product product) {
    return AppBar(
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
            icon: const Icon(Icons.close, color: AppColors.tertiary),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon:
              product.liked
                  ? Image.asset(
                    "assets/icons/heart_liked.png",
                    fit: BoxFit.cover,
                    width: 90,
                  )
                  : Image.asset(
                    "assets/icons/heart.png",
                    fit: BoxFit.cover,
                    width: 90,
                  ),
          onPressed: () {
            Provider.of<ProductProvider>(
              context,
              listen: false,
            ).toggleProductLike(widget.productId);
          },
        ),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 70,
        height: 5,
        decoration: BoxDecoration(
          color: Color(0xFFE3EBEC),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildProductHeader(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.access_time, size: 16, color: AppColors.tertiary),
                  SizedBox(width: 4),
                  Text(
                    '15 Min',
                    style: TextStyle(fontSize: 18, color: AppColors.tertiary),
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
                      !_expandedDescription && product.description.length > 100
                          ? '${product.description.substring(0, 100)}... '
                          : product.description,
                  style: TextStyle(fontSize: 16, color: AppColors.tertiary),
                ),
                if (product.description.length > 100)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedDescription = !_expandedDescription;
                        });
                      },
                      child: Text(
                        _expandedDescription ? 'View Less' : 'View More',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
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

  Widget _buildProductInfo(Product product) {
    final nutritionItems = [
      {'icon': "assets\\icons\\Carbs.png", 'value': '55g', 'label': 'carbs'},
      {
        'icon': "assets\\icons\\Proteins.png",
        'value': '27g',
        'label': 'proteins',
      },
      {
        'icon': "assets\\icons\\Calories.png",
        'value': '\$${product.price.toStringAsFixed(2)}',
        'label': 'price',
      },
      {
        'icon': "assets\\icons\\Fats.png",
        'value': product.category,
        'label': 'category',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInfoItem(nutritionItems[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem(nutritionItems[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInfoItem(nutritionItems[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoItem(nutritionItems[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(Map<String, String> item) {
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
              color: Color(0xFFe6ebf2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              item['icon']!,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${item['value']} ${item['label']}',
              style: const TextStyle(fontSize: 16, color: AppColors.primary),
              overflow: TextOverflow.ellipsis,
            ),
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
          color: const Color(0xFFE3EBEC),
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
                              ? AppColors.primary
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
                                : AppColors.primary,
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
                              ? AppColors.primary
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
                                : AppColors.primary,
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

  Widget _buildDetailsSection(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailItem('ID', product.id.toString()),
          _buildDetailItem('Title', product.title),
          _buildDetailItem('Price', '\$${product.price.toStringAsFixed(2)}'),
          _buildDetailItem('Category', product.category),
          _buildDetailItem('Description', product.description),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, color: Color(0xFF748189))),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.secondary,
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
          SectionTitle(title: "Creator", padding: 0),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/people/featured2.png'),
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
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Food blogger and recipe developer',
                      style: TextStyle(color: AppColors.tertiary, fontSize: 16),
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
}
