import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Product> _products = [];
  List<String> _categories = [];
  Product _product = Product(
    id: 0,
    title: '',
    price: 0.0,
    description: '',
    category: '',
    image: '',
);
  bool _isLoading = false;
  String _error = '';
  
  List<Product> get products => _products;
  List<String> get categories => _categories;
  Product get product => _product;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _products = await _apiService.getProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  Future<Product?> fetchProductById(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _product = await _apiService.getProduct(id);
      _isLoading = false;
      notifyListeners();
      return product;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
  
  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _products = await _apiService.getProductsByCategory(category);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  Future<void> fetchCategories() async {
    if (_categories.isNotEmpty) return; // Don't fetch if already loaded
    
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      _categories = await _apiService.getCategories();
      // Add 'All' category at the beginning
      if (!_categories.contains('All')) {
        _categories.insert(0, 'All');
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
