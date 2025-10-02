// lib/models/category_model.dart
class Category {
  final String id;
  final String title;
  final String handle;
  final String? description;
  final String? image;
  final String? parentId;
  final int position;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    required this.id,
    required this.title,
    required this.handle,
    this.description,
    this.image,
    this.parentId,
    this.position = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      handle: json['handle'] ?? '',
      description: json['description'],
      image: json['image'],
      parentId: json['parentId']?.toString(),
      position: json['position'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'handle': handle,
      'description': description,
      'image': image,
      'parentId': parentId,
      'position': position,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Category copyWith({
    String? id,
    String? title,
    String? handle,
    String? description,
    String? image,
    String? parentId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      handle: handle ?? this.handle,
      description: description ?? this.description,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}