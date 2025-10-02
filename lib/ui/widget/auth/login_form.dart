// lib/ui/widgets/auth/login_form.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../../utils/helpers/validators.dart'; // NEW
import '../../../utils/helpers/formatters.dart'; // NEW
import '../../../utils/themes/text_styles.dart'; // NEW
import '../../../constants/app_constants.dart'; // NEW

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
      widget.onLogin(_emailController.text.trim(), _passwordController.text);
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
            // Welcome Text - UPDATED with TextStyles
            Text(
              'Welcome Back',
              style: TextStyles.displayMedium.copyWith(
                color: Colors.black87,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              'Sign in to your account',
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(40)),

            // Error Message - UPDATED with better styling
            if (widget.error != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(12)),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[100]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: SizeConfig.getProportionateScreenWidth(16)),
                    SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
                    Expanded(
                      child: Text(
                        widget.error!,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.error != null) SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),

            // Email Field - UPDATED with Validators and Formatters
            _buildEmailField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Password Field - UPDATED with Validators
            _buildPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),

            // Forgot Password - UPDATED with TextStyles
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onForgotPasswordPressed,
                child: Text(
                  'Forgot Password?',
                  style: TextStyles.bodyMedium.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Login Button - UPDATED with better loading state
            _buildLoginButton(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Divider
            _buildDivider(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Social Login Buttons - UPDATED with AssetConstants
            _buildSocialLoginButtons(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Register Link - UPDATED with TextStyles
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
      textInputAction: TextInputAction.next,
      autocorrect: false,
      inputFormatters: [LowerCaseTextFormatter()], // NEW: Auto-format to lowercase
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'your@email.com',
        labelStyle: TextStyles.bodyLarge.copyWith(
          color: Colors.grey[600],
        ),
        hintStyle: TextStyles.bodyMedium.copyWith(
          color: Colors.grey[400],
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
      validator: Validators.email, // NEW: Using our Validator utility
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _submitForm(), // NEW: Submit on enter
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        labelStyle: TextStyles.bodyLarge.copyWith(
          color: Colors.grey[600],
        ),
        hintStyle: TextStyles.bodyMedium.copyWith(
          color: Colors.grey[400],
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
      validator: (value) => Validators.password(value), // NEW: Using our Validator utility
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.getProportionateScreenWidth(20),
                    height: SizeConfig.getProportionateScreenWidth(20),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: SizeConfig.getProportionateScreenWidth(12)),
                  Text(
                    'Signing In...',
                    style: TextStyles.labelLarge.copyWith(color: Colors.white),
                  ),
                ],
              )
            : Text(
                'Sign In',
                style: TextStyles.labelLarge.copyWith(
                  color: Colors.white,
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
            style: TextStyles.bodyMedium.copyWith(
              color: Colors.grey[500],
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
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: Colors.red,
          onPressed: () => _handleSocialLogin('google'),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        
        // Facebook
        _buildSocialButton(
          icon: Icons.facebook,
          color: Colors.blue[800]!,
          onPressed: () => _handleSocialLogin('facebook'),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        
        // Apple
        _buildSocialButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () => _handleSocialLogin('apple'),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: SizeConfig.getProportionateScreenWidth(30),
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyles.bodyMedium.copyWith(
            color: Colors.grey[600],
          ),
        ),
        GestureDetector(
          onTap: widget.onRegisterPressed,
          child: Text(
            'Sign Up',
            style: TextStyles.bodyMedium.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // NEW: Social login handler
  void _handleSocialLogin(String provider) {
    // You can integrate actual social login logic here
    print('$provider login pressed');
    
    // Show a temporary snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider login coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}