// lib/models/banner_model.dart
import 'dart:ui';

class BannerItem {
  final String id;
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? ctaText;
  final String? action;
  final Color? backgroundColor;
  final int displayOrder;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;

  BannerItem({
    required this.id,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.ctaText,
    this.action,
    this.backgroundColor,
    this.displayOrder = 0,
    this.isActive = true,
    this.startDate,
    this.endDate,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl'],
      title: json['title'],
      subtitle: json['subtitle'],
      ctaText: json['ctaText'],
      action: json['action'],
      backgroundColor: _parseColor(json['backgroundColor']),
      displayOrder: json['displayOrder'] ?? 0,
      isActive: json['isActive'] ?? true,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'ctaText': ctaText,
      'action': action,
      'backgroundColor': backgroundColor?.value.toRadixString(16),
      'displayOrder': displayOrder,
      'isActive': isActive,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }
}