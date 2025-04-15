import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<String> _categories = [];
  List<Product> _relatedProducts = [];
  int currentId = -1;
  List<int> nestedNav = [];

  // Simple list to store liked product IDs
  final List<int> _likedProductIds = [];
  Product _product = Product(
    id: 0,
    title: '',
    price: 0.0,
    description: '',
    category: '',
    image: '',
    liked: false,
  );
  bool _isLoading = false;
  bool _isCatLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<String> get categories => _categories;
  List<Product> get related => _relatedProducts;
  Product get product => _product;
  bool get isLoading => _isLoading;
  bool get isCatLoading => _isCatLoading;
  String get error => _error;
  int get nextID => nestedNav.isNotEmpty ? nestedNav.removeLast() : -1;

  Future<void> fetchProducts() async {
    print('Fetching products...');
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.getProducts();

      // Update liked status based on our stored IDs
      for (var i = 0; i < _products.length; i++) {
        _products[i] = Product(
          id: _products[i].id,
          title: _products[i].title,
          price: _products[i].price,
          description: _products[i].description,
          category: _products[i].category,
          image: _products[i].image,
          liked: _likedProductIds.contains(_products[i].id),
        );
      }
      _isLoading = false;
      print('Products fetched successfully!');
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Product fetchProductById(int id) {
    if (_product.id == id) return _product;
    fetchRelatedProducts(id);
    _product = products.firstWhere((product) => product.id == id);

    _product = Product(
      id: _product.id,
      title: _product.title,
      price: _product.price,
      description: _product.description,
      category: _product.category,
      image: _product.image,
      liked: _likedProductIds.contains(_product.id),
    );
    return _product;
  }

  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.getProductsByCategory(category);

      // Update liked status based on our stored IDs
      for (var i = 0; i < _products.length; i++) {
        _products[i] = Product(
          id: _products[i].id,
          title: _products[i].title,
          price: _products[i].price,
          description: _products[i].description,
          category: _products[i].category,
          image: _products[i].image,
          liked: _likedProductIds.contains(_products[i].id),
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    if (_categories.isNotEmpty) return;

    _isCatLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categories = await _apiService.getCategories();
      // Add 'All' category at the beginning
      if (!_categories.contains('All')) {
        _categories.insert(0, 'All');
      }
      _isCatLoading = false;
      notifyListeners();
    } catch (e) {
      _isCatLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchRelatedProducts(int id) async {
    if (currentId != id) {
      _error = '';
      currentId = id;
      try {
        // Update liked status based on our stored IDs
        for (var i = 0; i < _products.length; i++) {
          _products[i] = Product(
            id: _products[i].id,
            title: _products[i].title,
            price: _products[i].price,
            description: _products[i].description,
            category: _products[i].category,
            image: _products[i].image,
            liked: _likedProductIds.contains(_products[i].id),
          );
        }
        _relatedProducts =
            _products.where((product) => product.id != id).take(5).toList();
      } catch (e) {
        _error = e.toString();
      }
    }
  }

  void addNestedNav(int id) {
    nestedNav.add(id);
  }

  void toggleProductLike(int productId) {
    // Toggle in the liked IDs list
    if (_likedProductIds.contains(productId)) {
      _likedProductIds.remove(productId);
    } else {
      _likedProductIds.add(productId);
    }

    // Update product in the list
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      final isLiked = _likedProductIds.contains(productId);
      _products[index] = Product(
        id: _products[index].id,
        title: _products[index].title,
        price: _products[index].price,
        description: _products[index].description,
        category: _products[index].category,
        image: _products[index].image,
        liked: isLiked,
      );
    }

    // Update current product if needed
    if (_product.id == productId) {
      final isLiked = _likedProductIds.contains(productId);
      _product = Product(
        id: _product.id,
        title: _product.title,
        price: _product.price,
        description: _product.description,
        category: _product.category,
        image: _product.image,
        liked: isLiked,
      );
    }

    notifyListeners();
  }

  // Get all liked products
  List<Product> getLikedProducts() {
    return _products
        .where((product) => _likedProductIds.contains(product.id))
        .toList();
  }
}
