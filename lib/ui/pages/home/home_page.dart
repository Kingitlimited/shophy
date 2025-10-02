// lib/ui/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/ui/widget/common/error_widget.dart';
import 'package:shophy/ui/widget/common/loading_indicator.dart';
import 'package:shophy/ui/widget/home/banner_carousel.dart';
import 'package:shophy/ui/widget/home/category_grid.dart';
import 'package:shophy/ui/widget/home/featured_products.dart';
import '../../../utils/size_config.dart';
import '../../../providers/product_provider.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load products when the page initializes
    Future.microtask(() {
      ref.read(productProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    
    SizeConfig.init(context);
    
    return Scaffold(
      body: productState.isLoading
          ? LoadingIndicator(message: 'Loading products...')
          : productState.error != null
              ? CustomErrorWidget(
                  title: 'Failed to load products',
                  description: productState.error!,
                  buttonText: 'Retry',
                  onRetry: () {
                    ref.read(productProvider.notifier).loadProducts();
                  },
                )
              : _buildHomeContent(productState),
    );
  }

  Widget _buildHomeContent(ProductState productState) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
          
          // Banner Carousel
          BannerCarousel(),
          
          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
          
          // Categories Grid
          CategoryGrid(),
          
          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
          
          // Featured Products
          FeaturedProducts(
            featuredProducts: productState.featuredProducts,
            onViewAllPressed: () {
              print('View All Featured Products pressed');
            },
            onProductTap: (product) {
              print('Featured product tapped: ${product.title}');
              // Navigate to product detail page
            },
          ),

          SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),

          // Special Offers Section
          _buildSpecialOffersSection(),
        ],
      ),
    );
  }

  Widget _buildSpecialOffersSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getProportionateScreenWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Offers',
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(12)),
          Container(
            height: SizeConfig.getProportionateScreenHeight(120),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[100]!),
            ),
            child: Center(
              child: Text(
                'Special offers will appear here',
                style: TextStyle(
                  color: Colors.orange[800],
                  fontSize: SizeConfig.getProportionateScreenWidth(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}