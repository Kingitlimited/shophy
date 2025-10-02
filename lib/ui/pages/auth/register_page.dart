// lib/ui/pages/auth/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/ui/widget/auth/register_form.dart';
import '../../../utils/size_config.dart';
import '../../../providers/auth_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: SizeConfig.getProportionateScreenWidth(20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.getProportionateScreenHeight(20),
                  ),
                  child: Container(
                    width: SizeConfig.getProportionateScreenWidth(80),
                    height: SizeConfig.getProportionateScreenWidth(80),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: SizeConfig.getProportionateScreenWidth(40),
                    ),
                  ),
                ),

                // Register Form
                Expanded(
                  child: RegisterForm(
                    isLoading: authState.isLoading,
                    error: authState.error,
                    onRegister: (email, password, firstName, lastName) {
                      ref.read(authProvider.notifier).register(email, password, firstName, lastName);
                    },
                    onLoginPressed: () {
                      Navigator.pop(context);
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
}