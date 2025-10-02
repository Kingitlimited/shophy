// lib/ui/widgets/auth/register_form.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../../utils/helpers/validators.dart'; // NEW
import '../../../utils/helpers/formatters.dart'; // NEW
import '../../../utils/themes/text_styles.dart'; // NEW
import '../../../constants/app_constants.dart'; // NEW

class RegisterForm extends StatefulWidget {
  final bool isLoading;
  final String? error;
  final Function(String, String, String, String) onRegister;
  final VoidCallback? onLoginPressed;

  const RegisterForm({
    Key? key,
    required this.isLoading,
    required this.error,
    required this.onRegister,
    this.onLoginPressed,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      widget.onRegister(
        _emailController.text.trim(),
        _passwordController.text,
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );
    } else if (!_agreeToTerms) {
      // Show error if terms not agreed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the Terms of Service and Privacy Policy'),
          backgroundColor: Colors.red,
        ),
      );
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
              'Create Account',
              style: TextStyles.displayMedium.copyWith(
                color: Colors.black87,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              'Sign up to get started',
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

            // Name Fields
            Row(
              children: [
                Expanded(
                  child: _buildFirstNameField(), // UPDATED
                ),
                SizedBox(width: SizeConfig.getProportionateScreenWidth(12)),
                Expanded(
                  child: _buildLastNameField(), // UPDATED
                ),
              ],
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Email Field - UPDATED
            _buildEmailField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Password Field - UPDATED
            _buildPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Confirm Password Field - UPDATED
            _buildConfirmPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Terms and Conditions - UPDATED
            _buildTermsCheckbox(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Register Button - UPDATED
            _buildRegisterButton(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Divider - UPDATED
            _buildDivider(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Social Login Buttons - UPDATED
            _buildSocialLoginButtons(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Login Link - UPDATED
            _buildLoginLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'John',
        labelStyle: TextStyles.bodyLarge.copyWith(
          color: Colors.grey[600],
        ),
        hintStyle: TextStyles.bodyMedium.copyWith(
          color: Colors.grey[400],
        ),
        prefixIcon: Icon(
          Icons.person_outline,
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
      validator: (value) => Validators.required(value, 'First name'), // NEW
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Doe',
        labelStyle: TextStyles.bodyLarge.copyWith(
          color: Colors.grey[600],
        ),
        hintStyle: TextStyles.bodyMedium.copyWith(
          color: Colors.grey[400],
        ),
        prefixIcon: Icon(
          Icons.person_outline,
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
      validator: (value) => Validators.required(value, 'Last name'), // NEW
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      inputFormatters: [LowerCaseTextFormatter()], // NEW
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
      validator: Validators.email, // NEW
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.next,
      onChanged: (_) {
        // Trigger confirm password validation when password changes
        if (_confirmPasswordController.text.isNotEmpty) {
          _formKey.currentState?.validate();
        }
      },
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < AppConstants.minPasswordLength) { // NEW
          return 'Password must be at least ${AppConstants.minPasswordLength} characters';
        }
        if (!value.contains(RegExp(r'[A-Z]'))) {
          return 'Password must contain at least one uppercase letter';
        }
        if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password must contain at least one number';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _submitForm(), // NEW: Submit on enter
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
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
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[500],
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
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
      validator: (value) => Validators.confirmPassword(value, _passwordController.text), // NEW
    );
  }

  Widget _buildTermsCheckbox() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.getProportionateScreenHeight(8),
      ),
      decoration: BoxDecoration(
        color: !_agreeToTerms && _formKey.currentState?.validate() != null 
            ? Colors.red[50] 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            activeColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig.getProportionateScreenHeight(8)),
              child: Wrap(
                children: [
                  Text(
                    'I agree to the ',
                    style: TextStyles.bodyMedium.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Terms of Service pressed');
                      // TODO: Navigate to Terms of Service
                    },
                    child: Text(
                      'Terms of Service',
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    ' and ',
                    style: TextStyles.bodyMedium.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Privacy Policy pressed');
                      // TODO: Navigate to Privacy Policy
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: (widget.isLoading || !_agreeToTerms) ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: _agreeToTerms ? Colors.blue : Colors.grey[400],
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
                    'Creating Account...',
                    style: TextStyles.labelLarge.copyWith(color: Colors.white),
                  ),
                ],
              )
            : Text(
                'Create Account',
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
            'Or sign up with',
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
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          color: Colors.red,
          onPressed: () => _handleSocialSignUp('google'),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        _buildSocialButton(
          icon: Icons.facebook,
          color: Colors.blue[800]!,
          onPressed: () => _handleSocialSignUp('facebook'),
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
        _buildSocialButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () => _handleSocialSignUp('apple'),
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

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyles.bodyMedium.copyWith(
            color: Colors.grey[600],
          ),
        ),
        GestureDetector(
          onTap: widget.onLoginPressed,
          child: Text(
            'Sign In',
            style: TextStyles.bodyMedium.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // NEW: Social sign-up handler
  void _handleSocialSignUp(String provider) {
    print('$provider sign up pressed');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider sign up coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}