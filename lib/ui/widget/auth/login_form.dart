// lib/ui/widgets/auth/login_form.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final String? error;
  final Function(String, String) onLogin;
  final VoidCallback? onRegisterPressed;
  final VoidCallback? onForgotPasswordPressed;

  const LoginForm({
    Key? key,
    required this.isLoading,
    required this.error,
    required this.onLogin,
    this.onRegisterPressed,
    this.onForgotPasswordPressed,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Welcome Text
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              'Sign in to your account',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(16),
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(40)),

            // Error Message
            if (widget.error != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(12)),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.error!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                  ),
                ),
              ),
            if (widget.error != null) SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

            // Email Field
            _buildEmailField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Password Field
            _buildPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onForgotPasswordPressed,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Login Button
            _buildLoginButton(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Divider
            _buildDivider(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Social Login Buttons
            _buildSocialLoginButtons(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Register Link
            _buildRegisterLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: SizeConfig.getProportionateScreenWidth(16),
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.grey[500],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: SizeConfig.getProportionateScreenWidth(16),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.grey[500],
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[500],
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: widget.isLoading
            ? Container(
                width: SizeConfig.getProportionateScreenWidth(20),
                height: SizeConfig.getProportionateScreenWidth(20),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Sign In',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(16),
          ),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: SizeConfig.getProportionateScreenWidth(14),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google
        Container(
          width: SizeConfig.getProportionateScreenWidth(60),
          height: SizeConfig.getProportionateScreenWidth(60),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.g_mobiledata,
              size: SizeConfig.getProportionateScreenWidth(30),
              color: Colors.red,
            ),
            onPressed: () {
              print('Google login pressed');
            },
          ),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        
        // Facebook
        Container(
          width: SizeConfig.getProportionateScreenWidth(60),
          height: SizeConfig.getProportionateScreenWidth(60),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.facebook,
              size: SizeConfig.getProportionateScreenWidth(30),
              color: Colors.blue[800],
            ),
            onPressed: () {
              print('Facebook login pressed');
            },
          ),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        
        // Apple
        Container(
          width: SizeConfig.getProportionateScreenWidth(60),
          height: SizeConfig.getProportionateScreenWidth(60),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.apple,
              size: SizeConfig.getProportionateScreenWidth(30),
              color: Colors.black,
            ),
            onPressed: () {
              print('Apple login pressed');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: SizeConfig.getProportionateScreenWidth(14),
          ),
        ),
        GestureDetector(
          onTap: widget.onRegisterPressed,
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.blue,
              fontSize: SizeConfig.getProportionateScreenWidth(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}