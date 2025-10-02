// lib/ui/pages/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/providers/auth_provider.dart';
import 'package:shophy/ui/widget/auth/login_form.dart';
import 'package:shophy/utils/size_config.dart';
import 'package:shophy/utils/helpers/navigation.dart'; // NEW
import 'package:shophy/utils/themes/text_styles.dart'; // NEW
// NEW

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // NEW: Transparent for modern look
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: SizeConfig.getProportionateScreenWidth(20),
          ),
          onPressed: () {
            NavigationHelper.pop(context); // NEW: Using our NavigationHelper
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // NEW: Better scroll physics
          child: Container(
            height: SizeConfig.screenHeight -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
            child: Column(
              children: [
                // Logo Section - UPDATED with better styling
                _buildLogoSection(),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

                // Login Form
                Expanded(
                  child: LoginForm(
                    isLoading: authState.isLoading,
                    error: authState.error,
                    onLogin: (email, password) {
                      ref.read(authProvider.notifier).login(email, password);
                    },
                    onRegisterPressed: () {
                      NavigationHelper.pushNamed(context, '/register'); // NEW
                    },
                    onForgotPasswordPressed: () {
                      _handleForgotPassword(context); // NEW: Extracted method
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // NEW: Extracted logo section for better organization
  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.getProportionateScreenHeight(20),
      ),
      child: Column(
        children: [
          // Logo Container
          Container(
            width: SizeConfig.getProportionateScreenWidth(100), // Slightly larger
            height: SizeConfig.getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              gradient: LinearGradient( // NEW: Gradient for modern look
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade600, Colors.blue.shade400],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.shopping_bag_rounded, // NEW: Rounded icon for modern look
              color: Colors.white,
              size: SizeConfig.getProportionateScreenWidth(50),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          // App Name
          Text(
            'Shophy',
            style: TextStyles.displayMedium.copyWith( // NEW: Using TextStyles
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
          // Tagline
          Text(
            'Your Modern Shopping Companion',
            style: TextStyles.bodyMedium.copyWith( // NEW: Using TextStyles
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // NEW: Extracted forgot password handler
  void _handleForgotPassword(BuildContext context) {
    print('Navigate to forgot password page');
    
    // Show temporary message until forgot password page is created
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Forgot password feature coming soon!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    // TODO: Uncomment when forgot password page is ready
    // NavigationHelper.push(context, ForgotPasswordPage());
  }
}