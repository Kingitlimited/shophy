// lib/ui/widgets/home/banner_carousel.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.getProportionateScreenHeight(200),
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(12)),
        color: Colors.blue[50],
        image: DecorationImage(
          image: AssetImage('assets/images/banner_placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(12)),
          color: Colors.black.withOpacity(0.3),
        ),
        child: Center(
          child: Text(
            'Special Offers',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getProportionateScreenWidth(24),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}