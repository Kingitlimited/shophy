// lib/ui/pages/auth/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/providers/auth_provider.dart';
import 'package:shophy/ui/widget/auth/register_form.dart'; // Fixed import path
import 'package:shophy/utils/size_config.dart';
import 'package:shophy/utils/helpers/navigation.dart'; // NEW
import 'package:shophy/utils/themes/text_styles.dart'; // NEW
import 'package:shophy/constants/asset_constants.dart'; // NEW

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // NEW: Consistent with LoginPage
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
                // Logo Section - UPDATED to match LoginPage
                _buildLogoSection(),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

                // Register Form
                Expanded(
                  child: RegisterForm(
                    isLoading: authState.isLoading,
                    error: authState.error,
                    onRegister: (email, password, firstName, lastName) {
                      ref.read(authProvider.notifier).register(
                        email: email, 
                        password: password, 
                        firstName: firstName, 
                        lastName: lastName
                      );
                    },
                    onLoginPressed: () {
                      NavigationHelper.pop(context); // NEW: Using NavigationHelper
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

  // NEW: Extracted logo section matching LoginPage style
  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.getProportionateScreenHeight(20),
      ),
      child: Column(
        children: [
          // Logo Container
          Container(
            width: SizeConfig.getProportionateScreenWidth(100),
            height: SizeConfig.getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
              Icons.shopping_bag_rounded,
              color: Colors.white,
              size: SizeConfig.getProportionateScreenWidth(50),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
          // App Name
          Text(
            'Join Shophy',
            style: TextStyles.displayMedium.copyWith(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
          // Tagline
          Text(
            'Create your account to get started',
            style: TextStyles.bodyMedium.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}