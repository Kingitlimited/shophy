// lib/ui/widgets/profile/setting_tile.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showTrailingIcon;

  const SettingTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showTrailingIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: SizeConfig.getProportionateScreenWidth(40),
        height: SizeConfig.getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.blue,
          size: SizeConfig.getProportionateScreenWidth(20),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.getProportionateScreenWidth(16),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: showTrailingIcon
          ? Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: SizeConfig.getProportionateScreenWidth(16),
            )
          : null,
      onTap: onTap,
    );
  }
}