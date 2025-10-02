// lib/ui/widgets/product/product_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shophy/models/product_model.dart';
import 'package:shophy/providers/product_provider.dart';
import 'package:shophy/ui/widget/common/empty_state.dart';
import 'package:shophy/ui/widget/product/product_list_item.dart';
import 'package:shophy/utils/size_config.dart';

class ProductGrid extends ConsumerWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final String? productType;
  final String? categoryId; // NEW: Support category filtering

  const ProductGrid({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.75,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.productType,
    this.categoryId, // NEW
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    // Handle loading state
    if (productState.isLoading) {
      return _buildLoadingGrid();
    }

    // Handle error state
    if (productState.error != null) {
      return _buildErrorState(context, ref, productState.error!);
    }

    // Handle empty state
    final products = productState.products;
    
    // Enhanced filtering with category support
    List<Product> filteredProducts = products;
    
    if (categoryId != null) {
      filteredProducts = products.where((product) => 
        product.belongsToCategory(categoryId!)
      ).toList();
    }
    
    if (productType != null && productType!.isNotEmpty) {
      filteredProducts = filteredProducts.where((product) => 
        product.productType == productType
      ).toList();
    }

    if (filteredProducts.isEmpty) {
      return _buildEmptyState(context, ref, productType, categoryId);
    }

    return _buildProductGrid(filteredProducts, ref, context);
  }

  Widget _buildProductGrid(List<Product> products, WidgetRef ref, BuildContext context) {
    return GridView.builder(
      padding: padding ?? EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: SizeConfig.getProportionateScreenWidth(12),
        mainAxisSpacing: SizeConfig.getProportionateScreenHeight(12),
        childAspectRatio: childAspectRatio,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListItem(
          product: product,
          onTap: () => _navigateToProductDetail(context, product),
          onAddToCart: () => _addToCart(ref, product, context),
        );
      },
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(16)),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: SizeConfig.getProportionateScreenWidth(12),
        mainAxisSpacing: SizeConfig.getProportionateScreenHeight(12),
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildProductShimmer(),
    );
  }

  Widget _buildProductShimmer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: SizeConfig.getProportionateScreenHeight(14),
                  color: Colors.grey[200],
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(6)),
                Container(
                  width: SizeConfig.getProportionateScreenWidth(50),
                  height: SizeConfig.getProportionateScreenHeight(12),
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return EmptyState(
      title: 'Failed to Load Products',
      description: 'Please check your connection and try again',
      icon: Icons.error_outline,
      buttonText: 'Try Again',
      onButtonPressed: () {
        ref.refresh(productProvider);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref, String? productType, String? categoryId) {
    String description;
    
    if (categoryId != null && productType != null && productType!.isNotEmpty) {
      description = 'No products found in this category and type';
    } else if (categoryId != null) {
      description = 'No products available in this category';
    } else if (productType != null && productType!.isNotEmpty) {
      description = 'No products available in $productType';
    } else {
      description = 'Try adjusting your search criteria';
    }

    return EmptyState(
      title: 'No Products Found',
      description: description,
      icon: Icons.search_off,
      buttonText: 'Browse All',
      onButtonPressed: () {
        ref.refresh(productProvider);
      },
    );
  }

  void _navigateToProductDetail(BuildContext context, Product product) {
    // TODO: Navigate to product detail page
    print('Navigate to product detail: ${product.id}');
  }

  void _addToCart(WidgetRef ref, Product product, BuildContext context) {
    // TODO: Implement add to cart functionality using your cart provider
    print('Add to cart: ${product.id}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}