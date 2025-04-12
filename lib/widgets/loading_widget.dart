import 'package:first_proj/constants/constants.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  
  const LoadingWidget({
    Key? key,
    this.message = 'Loading...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.secondary,
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
