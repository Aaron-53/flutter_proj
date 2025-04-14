import 'package:first_proj/constants/constants.dart';
import 'package:first_proj/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class IngredientsList extends StatefulWidget {
  final Product product;

  const IngredientsList({Key? key, required this.product}) : super(key: key);

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  Map<String, int> _ingredientQuantities = {};

  // Sample ingredients that won't be from API
  final List<Map<String, String>> ingredients = [
    {
      'name': 'Tortilla Chips',
      'quantity': '2',
      'icon': "assets\\icons\\Tortilla.png",
    },
    {'name': 'Avocado', 'quantity': '1', 'icon': "assets\\icons\\Avocado.png"},
    {
      'name': 'Red Cabbage',
      'quantity': '1',
      'icon': "assets\\icons\\RedCabbage.png",
    },
    {'name': 'Peanuts', 'quantity': '1', 'icon': "assets\\icons\\Peanuts.png"},
    {
      'name': 'Red Onions',
      'quantity': '1',
      'icon': "assets\\icons\\RedOnion.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize quantities from the ingredients list
    for (var ingredient in ingredients) {
      _ingredientQuantities[ingredient['name']!] = int.parse(
        ingredient['quantity']!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Ingridients", actionText: "Add all to cart", padding: 0),
          const SizedBox(height: 4),
          Text(
            '${ingredients.length} items',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),
          ...ingredients.map((ingredient) => _buildIngredientItem(ingredient)),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(Map<String, String> ingredient) {
    final name = ingredient['name']!;
    final quantity = _ingredientQuantities[name] ?? 1;
    final bool isMinDisabled = quantity <= 1;
    final bool isMaxDisabled = quantity >= 9;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppDecorations.softShadow,
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
                ingredient['icon']!,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  // Minus button
                  GestureDetector(
                    onTap:
                        isMinDisabled
                            ? null
                            : () {
                              setState(() {
                                if (_ingredientQuantities[name]! > 1) {
                                  _ingredientQuantities[name] =
                                      _ingredientQuantities[name]! - 1;
                                }
                              });
                            },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                isMinDisabled
                                    ? Colors.grey.shade400
                                    : AppColors.secondary,
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color:
                              isMinDisabled
                                  ? Colors.grey.shade400
                                  : AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                  // Quantity display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.tertiary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Plus button
                  GestureDetector(
                    onTap:
                        isMaxDisabled
                            ? null
                            : () {
                              setState(() {
                                if (_ingredientQuantities[name]! < 9) {
                                  _ingredientQuantities[name] =
                                      _ingredientQuantities[name]! + 1;
                                }
                              });
                            },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                isMaxDisabled
                                    ? Colors.grey.shade400
                                    : AppColors.secondary,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color:
                              isMaxDisabled
                                  ? Colors.grey.shade400
                                  : AppColors.secondary,
                        ),
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
}
