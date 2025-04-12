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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      productProvider.fetchRelatedProducts(widget.currentProductId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        _relatedProducts = productProvider.related;
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
            productProvider.isLoading
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
      },
    );
  }
}
