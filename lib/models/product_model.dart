// lib/models/product_model.dart
class Product {
  final String id;
  final String title;
  final String description;
  final String handle;
  final List<ProductVariant> variants;
  final List<ProductImage> images;
  final List<String> tags;
  final String productType;
  final String vendor;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool available;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.handle,
    required this.variants,
    required this.images,
    this.tags = const [],
    this.productType = '',
    this.vendor = '',
    this.createdAt,
    this.updatedAt,
    this.available = true,
  });

  ProductVariant get defaultVariant => variants.first;

  double get averageRating {
    if (variants.isEmpty) return 0.0;
    final ratings = variants.expand((v) => v.reviews).map((r) => r.rating).toList();
    if (ratings.isEmpty) return 0.0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }

  int get reviewCount {
    return variants.expand((v) => v.reviews).length;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      handle: json['handle'] ?? '',
      variants: (json['variants'] as List? ?? []).map((v) => ProductVariant.fromJson(v)).toList(),
      images: (json['images'] as List? ?? []).map((i) => ProductImage.fromJson(i)).toList(),
      tags: List<String>.from(json['tags'] ?? []),
      productType: json['productType'] ?? '',
      vendor: json['vendor'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      available: json['available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'handle': handle,
      'variants': variants.map((v) => v.toJson()).toList(),
      'images': images.map((i) => i.toJson()).toList(),
      'tags': tags,
      'productType': productType,
      'vendor': vendor,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'available': available,
    };
  }
}

class ProductVariant {
  final String id;
  final String productId;
  final String title;
  final double price;
  final double? compareAtPrice;
  final String sku;
  final int position;
  final bool available;
  final Map<String, String> selectedOptions;
  final List<ProductReview> reviews;

  ProductVariant({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.compareAtPrice,
    this.sku = '',
    this.position = 0,
    this.available = true,
    this.selectedOptions = const {},
    this.reviews = const [],
  });

  bool get onSale => compareAtPrice != null && compareAtPrice! > price;

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      sku: json['sku'] ?? '',
      position: json['position'] ?? 0,
      available: json['available'] ?? true,
      selectedOptions: Map<String, String>.from(json['selectedOptions'] ?? {}),
      reviews: (json['reviews'] as List? ?? []).map((r) => ProductReview.fromJson(r)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'compareAtPrice': compareAtPrice,
      'sku': sku,
      'position': position,
      'available': available,
      'selectedOptions': selectedOptions,
      'reviews': reviews.map((r) => r.toJson()).toList(),
    };
  }
}

class ProductImage {
  final String id;
  final String productId;
  final int position;
  final String src;
  final String? altText;

  ProductImage({
    required this.id,
    required this.productId,
    required this.position,
    required this.src,
    this.altText,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      position: json['position'] ?? 0,
      src: json['src'] ?? '',
      altText: json['altText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'position': position,
      'src': src,
      'altText': altText,
    };
  }
}

class ProductReview {
  final String id;
  final String variantId;
  final String customerName;
  final String? customerEmail;
  final int rating;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool verified;

  ProductReview({
    required this.id,
    required this.variantId,
    required this.customerName,
    this.customerEmail,
    required this.rating,
    required this.title,
    required this.body,
    required this.createdAt,
    this.verified = false,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id']?.toString() ?? '',
      variantId: json['variantId']?.toString() ?? '',
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'],
      rating: json['rating'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      verified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variantId': variantId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'rating': rating,
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'verified': verified,
    };
  }
}