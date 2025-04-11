import 'package:first_proj/main.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';
import '../widgets/ingredients_list.dart';
import '../widgets/related_products.dart';

class RecipeDetailScreen extends StatefulWidget {
  final int productId;

  const RecipeDetailScreen({super.key, required this.productId});

  @override
  State createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _selectedTabIndex = 0;

  void onClose() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      productProvider.fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        if (productProvider.isLoading) {
          return Scaffold(body: Center(child: LoadingWidget()));
        }

        if (productProvider.error.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${productProvider.error}')),
          );
        }

        final product = productProvider.product;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              // Full-screen background image
              product.image.startsWith('http')
                  ? Image.network(
                    product.image,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      );
                    },
                  )
                  : Image.asset(
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
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
                          _buildDragHandle(),
                          SizedBox(height: 20),
                          _buildProductHeader(),
                          _buildProductInfo(),
                          _buildTabSection(),
                          _selectedTabIndex == 0
                              ? IngredientsList(product: product)
                              : _buildDetailsSection(),
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
    ); //hii
  }

  // UI Component Methods

  PreferredSizeWidget _buildAppBar() {
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
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Image.asset(
            "assets/icons/heart.png",
            fit: BoxFit.cover,
            width: 90,
          ),
          onPressed: () {},
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

  Widget _buildProductHeader() {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
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
                  productProvider.product.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A2533),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      productProvider.product.description.length > 100
                          ? '${productProvider.product.description.substring(0, 100)}... '
                          : productProvider.product.description,
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

  Widget _buildProductInfo() {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final nutritionItems = [
      {'icon': "assets\\icons\\Carbs.png", 'value': '55g', 'label': 'carbs'},
      {
        'icon': "assets\\icons\\Proteins.png",
        'value': '27g',
        'label': 'proteins',
      },
      {
        'icon': "assets\\icons\\Calories.png",
        'value': '\$${productProvider.product.price.toStringAsFixed(2)}',
        'label': 'price',
      },
      {
        'icon': "assets\\icons\\Fats.png",
        'value': productProvider.product.category,
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
              color: Colors.white,
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
              style: const TextStyle(fontSize: 16, color: Color(0xFF0A2533)),
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
                      'Details',
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

  Widget _buildDetailsSection() {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
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
          _buildDetailItem('ID', productProvider.product.id.toString()),
          _buildDetailItem('Title', productProvider.product.title),
          _buildDetailItem('Price', '\$${productProvider.product.price.toStringAsFixed(2)}'),
          _buildDetailItem('Category', productProvider.product.category),
          _buildDetailItem('Description', productProvider.product.description),
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
              color: Color(0xFF0A2533),
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
}
