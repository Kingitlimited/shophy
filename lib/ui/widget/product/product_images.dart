// lib/ui/widgets/product/product_images.dart
import 'package:flutter/material.dart';
import 'package:shophy/utils/size_config.dart';

class ProductImages extends StatefulWidget {
  final List<String> images;
  final String? selectedVariantImage;

  const ProductImages({
    Key? key,
    required this.images,
    this.selectedVariantImage,
  }) : super(key: key);

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int _selectedImageIndex = 0;

  List<String> get _displayImages {
    if (widget.selectedVariantImage != null) {
      return [widget.selectedVariantImage!, ...widget.images];
    }
    return widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Image
        Container(
          width: double.infinity,
          height: SizeConfig.getProportionateScreenWidth(300),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _displayImages.isNotEmpty
                ? Image.network(
                    _displayImages[_selectedImageIndex],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildPlaceholderImage();
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : _buildPlaceholderImage(),
          ),
        ),
        
        SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
        
        // Image Thumbnails
        if (_displayImages.length > 1)
          SizedBox(
            height: SizeConfig.getProportionateScreenWidth(60),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _displayImages.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
              itemBuilder: (context, index) {
                return _buildThumbnail(index);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildThumbnail(int index) {
    final isSelected = index == _selectedImageIndex;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImageIndex = index;
        });
      },
      child: Container(
        width: SizeConfig.getProportionateScreenWidth(60),
        height: SizeConfig.getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            _displayImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.photo,
                  color: Colors.grey[400],
                  size: SizeConfig.getProportionateScreenWidth(20),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library,
            size: SizeConfig.getProportionateScreenWidth(64),
            color: Colors.grey[400],
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          Text(
            'No Image Available',
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(14),
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}