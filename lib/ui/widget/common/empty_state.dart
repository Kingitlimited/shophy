// lib/ui/widgets/common/empty_state.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.inbox,
    this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: SizeConfig.getProportionateScreenWidth(80),
              color: Colors.grey[300],
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
            Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(18),
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
            Text(
              textAlign: TextAlign.center,
              description,
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.grey[500],
                
              ),
            ),
            if (buttonText != null) ...[
              SizedBox(height: SizeConfig.getProportionateScreenHeight(24)),
              Container(
                height: SizeConfig.getProportionateScreenHeight(50),
                width: SizeConfig.getProportionateScreenWidth(200),
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    buttonText!,
                    style: TextStyle(
                      fontSize: SizeConfig.getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}