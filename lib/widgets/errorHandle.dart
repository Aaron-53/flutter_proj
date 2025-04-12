import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final bool showDismissButton;
  
  const ErrorDisplayWidget({
    Key? key,
    this.onRetry,
    this.showDismissButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.error.isEmpty) {
          return SizedBox.shrink();
        }
        
        // Determine error type based on error message content
        final errorInfo = _getErrorInfo(provider.error);
        
        return Container(
          width: double.infinity,
          color: errorInfo.color,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Icon(errorInfo.icon, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  errorInfo.displayMessage,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (onRetry != null)
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: onRetry,
                  tooltip: 'Retry',
                ),
              if (showDismissButton)
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      // Use ScaffoldMessenger to dismiss the error since we can't modify provider
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    tooltip: 'Dismiss',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
  
  ErrorInfo _getErrorInfo(String errorMessage) {
    final lowerCaseError = errorMessage.toLowerCase();
    // Network related errors
    if (lowerCaseError.contains('socketexception') || 
        lowerCaseError.contains('network') ||
        lowerCaseError.contains('internet') ||
        lowerCaseError.contains('connection')) {
      return ErrorInfo(
        displayMessage: 'No internet connection. Please check your network settings.',
        icon: Icons.signal_wifi_off,
        color: Colors.orange,
      );
    }
    
    // Timeout errors
    if (lowerCaseError.contains('timeout') || 
        lowerCaseError.contains('timed out')) {
      return ErrorInfo(
        displayMessage: 'Request timed out. Please try again later.',
        icon: Icons.timer_off,
        color: Colors.amber.shade700,
      );
    }
    
    // Server errors
    if (lowerCaseError.contains('500') || 
        lowerCaseError.contains('server error')) {
      return ErrorInfo(
        displayMessage: 'Server error. Please try again later.',
        icon: Icons.cloud_off,
        color: Colors.red,
      );
    }
    
    // Not found errors
    if (lowerCaseError.contains('404') || 
        lowerCaseError.contains('not found')) {
      return ErrorInfo(
        displayMessage: 'Resource not found.',
        icon: Icons.find_in_page_outlined,
        color: Colors.purple,
      );
    }
    
    // Authentication errors
    if (lowerCaseError.contains('401') || 
        lowerCaseError.contains('unauthorized')) {
      return ErrorInfo(
        displayMessage: 'Authentication error. Please login again.',
        icon: Icons.lock_outline,
        color: Colors.red.shade800,
      );
    }
    
    // Format errors
    if (lowerCaseError.contains('format') || 
        lowerCaseError.contains('parse') ||
        lowerCaseError.contains('json')) {
      return ErrorInfo(
        displayMessage: 'Data format error. Please contact support.',
        icon: Icons.data_array,
        color: Colors.teal.shade700,
      );
    }
    
    // Default for unknown errors
    return ErrorInfo(
      displayMessage: errorMessage,
      icon: Icons.error_outline,
      color: Colors.red.shade700,
    );
  }
}

// Helper class to store error display information
class ErrorInfo {
  final String displayMessage;
  final IconData icon;
  final Color color;
  
  ErrorInfo({
    required this.displayMessage,
    required this.icon,
    required this.color,
  });
}