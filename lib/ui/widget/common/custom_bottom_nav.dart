// lib/ui/widgets/common/custom_bottom_nav.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: TextStyle(
          fontSize: SizeConfig.getProportionateScreenWidth(10),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: SizeConfig.getProportionateScreenWidth(10),
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              child: Icon(
                Icons.home,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              child: Icon(
                Icons.favorite_border,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              child: Icon(
                Icons.shopping_cart,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              child: Icon(
                Icons.person_outline,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(6)),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: SizeConfig.getProportionateScreenWidth(22),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}