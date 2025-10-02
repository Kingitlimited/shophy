// lib/ui/pages/wishlist/wishlist_page.dart
import 'package:flutter/material.dart';
import 'package:shophy/ui/widget/common/empty_state.dart';
import '../../../utils/size_config.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
            Text(
              'My Wishlist',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(4)),
            Text(
              'Your favorite items',
              style: TextStyle(
                fontSize: SizeConfig.getProportionateScreenWidth(14),
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            
            // Using EmptyState widget
            Expanded(
              child: EmptyState(
                title: 'Your wishlist is empty',
                description: 'Start adding items you love to your wishlist',
                icon: Icons.favorite_border,
                buttonText: 'Start Shopping',
                onButtonPressed: () {
                  // Navigate to products page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}