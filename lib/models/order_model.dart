// lib/models/order_model.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class Order {
  final String id;
  final String orderNumber;
  final OrderCustomer customer;
  final List<OrderLineItem> lineItems;
  final OrderPrice price;
  final OrderShippingAddress? shippingAddress;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? processedAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customer,
    required this.lineItems,
    required this.price,
    this.shippingAddress,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.processedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id']?.toString() ?? '',
      orderNumber: json['orderNumber']?.toString() ?? '',
      customer: OrderCustomer.fromJson(json['customer'] ?? {}),
      lineItems: (json['lineItems'] as List? ?? []).map((item) => OrderLineItem.fromJson(item)).toList(),
      price: OrderPrice.fromJson(json['price'] ?? {}),
      shippingAddress: json['shippingAddress'] != null ? OrderShippingAddress.fromJson(json['shippingAddress']) : null,
      status: OrderStatus.values.firstWhere((e) => e.name == (json['status'] ?? 'PENDING'), orElse: () => OrderStatus.PENDING),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      processedAt: json['processedAt'] != null ? DateTime.parse(json['processedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'customer': customer.toJson(),
      'lineItems': lineItems.map((item) => item.toJson()).toList(),
      'price': price.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
    };
  }
}

class OrderCustomer {
  final String id;
  final String? firstName;
  final String? lastName;
  final String email;

  OrderCustomer({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
  });

  String get fullName => [firstName, lastName].where((n) => n != null && n.isNotEmpty).join(' ');

  factory OrderCustomer.fromJson(Map<String, dynamic> json) {
    return OrderCustomer(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

class OrderLineItem {
  final String id;
  final String productId;
  final String variantId;
  final String title;
  final int quantity;
  final double price;
  final String? image;

  OrderLineItem({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.title,
    required this.quantity,
    required this.price,
    this.image,
  });

  double get totalPrice => price * quantity;

  factory OrderLineItem.fromJson(Map<String, dynamic> json) {
    return OrderLineItem(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      variantId: json['variantId']?.toString() ?? '',
      title: json['title'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'variantId': variantId,
      'title': title,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}

class OrderPrice {
  final double subtotal;
  final double total;
  final double tax;
  final double shipping;
  final double? discount;

  OrderPrice({
    required this.subtotal,
    required this.total,
    required this.tax,
    required this.shipping,
    this.discount,
  });

  factory OrderPrice.fromJson(Map<String, dynamic> json) {
    return OrderPrice(
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'total': total,
      'tax': tax,
      'shipping': shipping,
      'discount': discount,
    };
  }
}

class OrderShippingAddress {
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? province;
  final String? country;
  final String? zip;
  final String? phone;

  OrderShippingAddress({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.province,
    this.country,
    this.zip,
    this.phone,
  });

  String get fullName => [firstName, lastName].where((n) => n != null && n.isNotEmpty).join(' ');

  factory OrderShippingAddress.fromJson(Map<String, dynamic> json) {
    return OrderShippingAddress(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      province: json['province'],
      country: json['country'],
      zip: json['zip'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'province': province,
      'country': country,
      'zip': zip,
      'phone': phone,
    };
  }
}

enum OrderStatus {
  PENDING,
  CONFIRMED,
  PAID,
  PROCESSING,
  FULFILLED,
  COMPLETED,
  CANCELLED,
  REFUNDED,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.PENDING:
        return 'Pending';
      case OrderStatus.CONFIRMED:
        return 'Confirmed';
      case OrderStatus.PAID:
        return 'Paid';
      case OrderStatus.PROCESSING:
        return 'Processing';
      case OrderStatus.FULFILLED:
        return 'Shipped';
      case OrderStatus.COMPLETED:
        return 'Delivered';
      case OrderStatus.CANCELLED:
        return 'Cancelled';
      case OrderStatus.REFUNDED:
        return 'Refunded';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.PENDING:
        return Colors.orange;
      case OrderStatus.CONFIRMED:
        return Colors.blue;
      case OrderStatus.PAID:
        return Colors.green;
      case OrderStatus.PROCESSING:
        return Colors.purple;
      case OrderStatus.FULFILLED:
        return Colors.teal;
      case OrderStatus.COMPLETED:
        return Colors.green;
      case OrderStatus.CANCELLED:
        return Colors.red;
      case OrderStatus.REFUNDED:
        return Colors.grey;
    }
  }
}