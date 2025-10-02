// lib/ui/widgets/home/category_grid.dart
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      _Category('Electronics', Icons.electrical_services),
      _Category('Fashion', Icons.shopping_bag),
      _Category('Home', Icons.home),
      _Category('Beauty', Icons.face),
      _Category('Sports', Icons.sports_baseball),
      _Category('More', Icons.more_horiz),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: SizeConfig.getProportionateScreenWidth(12),
              mainAxisSpacing: SizeConfig.getProportionateScreenHeight(12),
              childAspectRatio: 0.8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(categories[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(_Category category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.getProportionateScreenWidth(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.getProportionateScreenWidth(50),
            height: SizeConfig.getProportionateScreenWidth(50),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              category.icon,
              color: Colors.blue,
              size: SizeConfig.getProportionateScreenWidth(24),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          Text(
            category.name,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(12),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _Category {
  final String name;
  final IconData icon;

  _Category(this.name, this.icon);
}