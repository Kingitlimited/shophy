// lib/models/cart_model.dart
class Cart {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final double subtotalPrice;
  final double? discount;
  final double tax;
  final double shipping;
  final int totalItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Cart({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.subtotalPrice,
    this.discount,
    required this.tax,
    required this.shipping,
    required this.totalItems,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.empty() {
    return Cart(
      id: '',
      items: [],
      totalPrice: 0.0,
      subtotalPrice: 0.0,
      tax: 0.0,
      shipping: 0.0,
      totalItems: 0,
    );
  }

  bool get isEmpty => items.isEmpty;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id']?.toString() ?? '',
      items: (json['items'] as List? ?? []).map((item) => CartItem.fromJson(item)).toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      subtotalPrice: (json['subtotalPrice'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0.0,
      totalItems: json['totalItems'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'subtotalPrice': subtotalPrice,
      'discount': discount,
      'tax': tax,
      'shipping': shipping,
      'totalItems': totalItems,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Cart copyWith({
    String? id,
    List<CartItem>? items,
    double? totalPrice,
    double? subtotalPrice,
    double? discount,
    double? tax,
    double? shipping,
    int? totalItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      subtotalPrice: subtotalPrice ?? this.subtotalPrice,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      shipping: shipping ?? this.shipping,
      totalItems: totalItems ?? this.totalItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CartItem {
  final String id;
  final String productId;
  final String variantId;
  final String productTitle;
  final String variantTitle;
  final double price;
  final int quantity;
  final String image;
  final Map<String, String> selectedOptions;

  CartItem({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.productTitle,
    required this.variantTitle,
    required this.price,
    required this.quantity,
    required this.image,
    this.selectedOptions = const {},
  });

  double get totalPrice => price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      variantId: json['variantId']?.toString() ?? '',
      productTitle: json['productTitle'] ?? '',
      variantTitle: json['variantTitle'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
      image: json['image'] ?? '',
      selectedOptions: Map<String, String>.from(json['selectedOptions'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'variantId': variantId,
      'productTitle': productTitle,
      'variantTitle': variantTitle,
      'price': price,
      'quantity': quantity,
      'image': image,
      'selectedOptions': selectedOptions,
    };
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? variantId,
    String? productTitle,
    String? variantTitle,
    double? price,
    int? quantity,
    String? image,
    Map<String, String>? selectedOptions,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      productTitle: productTitle ?? this.productTitle,
      variantTitle: variantTitle ?? this.variantTitle,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      selectedOptions: selectedOptions ?? this.selectedOptions,
    );
  }
}