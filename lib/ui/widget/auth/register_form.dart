// lib/ui/widgets/auth/register_form.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

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
        _emailController.text,
        _passwordController.text,
        _firstNameController.text,
        _lastNameController.text,
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
            // Welcome Text
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              'Sign up to get started',
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

            // Name Fields
            Row(
              children: [
                Expanded(
                  child: _buildFirstNameField(),
                ),
                SizedBox(width: SizeConfig.getProportionateScreenWidth(12)),
                Expanded(
                  child: _buildLastNameField(),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Email Field
            _buildEmailField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Password Field
            _buildPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Confirm Password Field
            _buildConfirmPasswordField(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

            // Terms and Conditions
            _buildTermsCheckbox(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Register Button
            _buildRegisterButton(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Divider
            _buildDivider(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Social Login Buttons
            _buildSocialLoginButtons(),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),

            // Login Link
            _buildLoginLink(),
          ],
        ),
      ),
    );
  }
  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: SizeConfig.getProportionateScreenWidth(16),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }
        if (value.length < 2) {
          return 'First name must be at least 2 characters';
        }
        return null;
      },
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: 'Last Name',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: SizeConfig.getProportionateScreenWidth(16),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        if (value.length < 2) {
          return 'Last name must be at least 2 characters';
        }
        return null;
      },
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
      decoration: InputDecoration(
        labelText: 'Confirm Password',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
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
          child: Wrap(
            children: [
              Text(
                'I agree to the ',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(14),
                  color: Colors.grey[600],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Terms of Service pressed');
                },
                child: Text(
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                ' and ',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(14),
                  color: Colors.grey[600],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Privacy Policy pressed');
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

 Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: (widget.isLoading || !_agreeToTerms) ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: _agreeToTerms ? Colors.blue : Colors.grey[400],
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
                'Create Account',
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
            'Or sign up with',
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
              print('Google sign up pressed');
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
              print('Facebook sign up pressed');
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
              print('Apple sign up pressed');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: SizeConfig.getProportionateScreenWidth(14),
          ),
        ),
        GestureDetector(
          onTap: widget.onLoginPressed,
          child: Text(
            'Sign In',
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