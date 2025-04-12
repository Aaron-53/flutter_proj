import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => statusCode != null 
      ? 'ApiException: $message (Status Code: $statusCode)' 
      : 'ApiException: $message';
}

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  final http.Client _client;
  
  // Dependency injection for better testability
  ApiService({http.Client? client}) : _client = client ?? http.Client();
  
  // Generic request handler to reduce code duplication
  Future<dynamic> _handleRequest(Future<http.Response> Function() requestFunction, String errorMessage) async {
    try {
      final response = await requestFunction();
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException('$errorMessage: ${response.reasonPhrase}', response.statusCode);
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network settings.');
    } on FormatException {
      throw ApiException('Invalid response format');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: $e');
    }
  }
  
  // Get all products
  Future<List<Product>> getProducts() async {
    final data = await _handleRequest(
      () => _client.get(Uri.parse('$baseUrl/products')).timeout(const Duration(seconds: 10)),
      'Failed to load products'
    );
    
    return (data as List).map((json) => Product.fromJson(json)).toList();
  }
  
  // Get a single product
  Future<Product> getProduct(int id) async {
    final data = await _handleRequest(
      () => _client.get(Uri.parse('$baseUrl/products/$id')).timeout(const Duration(seconds: 10)),
      'Failed to load product'
    );
    
    return Product.fromJson(data);
  }
  
  // Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await _handleRequest(
      () => _client.get(Uri.parse('$baseUrl/products/category/$category')).timeout(const Duration(seconds: 10)),
      'Failed to load products by category'
    );
    
    return (data as List).map((json) => Product.fromJson(json)).toList();
  }
  
  // Get all categories
  Future<List<String>> getCategories() async {
    final data = await _handleRequest(
      () => _client.get(Uri.parse('$baseUrl/products/categories')).timeout(const Duration(seconds: 10)),
      'Failed to load categories'
    );
    
    return (data as List).map((category) => category.toString()).toList();
  }
  
  // Properly clean up resources
  void dispose() {
    _client.close();
  }
}