// lib/ui/widgets/common/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/size_config.dart';
import '../../../providers/cart_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String appName;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    Key? key,
    this.appName = "Shophy",
    this.onMenuPressed,
    this.onProfilePressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.getProportionateScreenHeight(60));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.black12,
      leading: Container(
        margin: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(8)),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.menu, 
            color: Colors.black87,
            size: SizeConfig.getProportionateScreenWidth(20),
          ),
          onPressed: onMenuPressed,
        ),
      ),
      title: Text(
        appName,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.getProportionateScreenWidth(18),
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        // Cart Icon with Badge
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black87,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
              onPressed: () {
                // Navigate to cart page
                Navigator.pushNamed(context, '/cart');
              },
            ),
            if (cart.totalItems > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    cart.totalItems > 99 ? '99+' : cart.totalItems.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
        // Profile Avatar
        Padding(
          padding: EdgeInsets.only(right: SizeConfig.getProportionateScreenWidth(12)),
          child: GestureDetector(
            onTap: onProfilePressed,
            child: Container(
              width: SizeConfig.getProportionateScreenWidth(40),
              height: SizeConfig.getProportionateScreenWidth(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile_placeholder.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[500],
                        size: SizeConfig.getProportionateScreenWidth(20),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}