// lib/ui/widgets/profile/profile_header.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../../models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;
  final VoidCallback onLoginPressed;

  const ProfileHeader({
    Key? key,
    required this.user,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.getProportionateScreenWidth(70),
            height: SizeConfig.getProportionateScreenWidth(70),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: ClipOval(
              child: user?.avatar != null
                  ? Image.asset(
                      user!.avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    )
                  : _buildDefaultAvatar(),
            ),
          ),
          SizedBox(width: SizeConfig.getProportionateScreenWidth(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.fullName ?? 'Guest User',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
                Text(
                  user?.email ?? 'guest@example.com',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(14),
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
                if (user == null)
                  Container(
                    height: SizeConfig.getProportionateScreenHeight(36),
                    child: OutlinedButton(
                      onPressed: onLoginPressed,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        'Login / Register',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: SizeConfig.getProportionateScreenWidth(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Icon(
        Icons.person,
        color: Colors.grey[500],
        size: SizeConfig.getProportionateScreenWidth(30),
      ),
    );
  }
}