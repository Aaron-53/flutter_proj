import 'package:first_proj/widgets/itemcard.dart';
import 'package:first_proj/widgets/loading_widget.dart';
import 'package:first_proj/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';

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
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    productProvider.fetchRelatedProducts(widget.currentProductId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        _relatedProducts = productProvider.related;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Related Products", actionText: "View All"),
            const SizedBox(height: 10),
            productProvider.isLoading
                ? Center(child: LoadingWidget())
                : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: _relatedProducts.length,
                    itemBuilder: (context, index) {
                      final product = _relatedProducts[index];
                      return AspectRatio(
                        aspectRatio: 5 / 6,
                        child: ItemCard(
                          imagePath: product.image,
                          title: product.title,
                          details: false,
                          showLiked: false,
                          id: product.id,
                          textLines: 1,
                        ),
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
