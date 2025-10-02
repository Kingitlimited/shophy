// lib/ui/widgets/common/error_widget.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onRetry;
  final IconData? icon;

  const CustomErrorWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onRetry,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error Icon
          Container(
            width: SizeConfig.getProportionateScreenWidth(100),
            height: SizeConfig.getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.error_outline,
              color: Colors.red,
              size: SizeConfig.getProportionateScreenWidth(50),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),

          // Error Title
          Text(
            title,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),

          // Error Description
          Text(
            description,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(16),
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(32)),

          // Retry Button
          Container(
            height: SizeConfig.getProportionateScreenHeight(50),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: SizeConfig.getProportionateScreenWidth(18),
                  ),
                  SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: SizeConfig.getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

          // Alternative Action
          TextButton(
            onPressed: () {
              // Go back or take alternative action
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Text(
              'Go Back',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Specific error widgets for common scenarios
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorWidget({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Network Error',
      description: 'Unable to connect to the server. '
          'Please check your internet connection and try again.',
      buttonText: 'Retry Connection',
      onRetry: onRetry,
      icon: Icons.wifi_off,
    );
  }
}

class ServerErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const ServerErrorWidget({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Server Error',
      description: 'Something went wrong on our end. '
          'Our team has been notified and we\'re working to fix it.',
      buttonText: 'Try Again',
      onRetry: onRetry,
      icon: Icons.cloud_off,
    );
  }
}

class NotFoundErrorWidget extends StatelessWidget {
  final String itemName;
  final VoidCallback onRetry;

  const NotFoundErrorWidget({
    Key? key,
    required this.itemName,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: '$itemName Not Found',
      description: 'The $itemName you\'re looking for doesn\'t exist '
          'or may have been removed.',
      buttonText: 'Go Back',
      onRetry: onRetry,
      icon: Icons.search_off,
    );
  }
}

class PermissionErrorWidget extends StatelessWidget {
  final String permissionType;
  final VoidCallback onRetry;

  const PermissionErrorWidget({
    Key? key,
    required this.permissionType,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Permission Required',
      description: 'This app needs $permissionType permission to function properly. '
          'Please enable it in your device settings.',
      buttonText: 'Grant Permission',
      onRetry: onRetry,
      icon: Icons.lock_outline, // Using lock icon instead of non-existent permission_denied
    );
  }
}

// Additional error types
class EmptyDataErrorWidget extends StatelessWidget {
  final String itemName;
  final VoidCallback onRetry;

  const EmptyDataErrorWidget({
    Key? key,
    required this.itemName,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'No $itemName Found',
      description: 'There are no $itemName available at the moment. '
          'Please check back later.',
      buttonText: 'Refresh',
      onRetry: onRetry,
      icon: Icons.inbox_outlined,
    );
  }
}

class TimeoutErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const TimeoutErrorWidget({
    Key? key,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'Request Timeout',
      description: 'The request took too long to complete. '
          'Please check your connection and try again.',
      buttonText: 'Retry',
      onRetry: onRetry,
      icon: Icons.timer_off,
    );
  }
}