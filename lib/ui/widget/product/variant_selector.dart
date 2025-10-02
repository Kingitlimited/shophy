// lib/ui/widgets/product/variant_selector.dart
import 'package:flutter/material.dart';
import 'package:shophy/models/product_model.dart';
import 'package:shophy/utils/size_config.dart';

class VariantSelector extends StatefulWidget {
  final Product product;
  final ProductVariant? selectedVariant;
  final ValueChanged<ProductVariant> onVariantChanged;

  const VariantSelector({
    Key? key,
    required this.product,
    required this.selectedVariant,
    required this.onVariantChanged,
  }) : super(key: key);

  @override
  State<VariantSelector> createState() => _VariantSelectorState();
}

class _VariantSelectorState extends State<VariantSelector> {
  final Map<String, String> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _initializeSelections();
  }

  void _initializeSelections() {
    if (widget.selectedVariant != null) {
      _selectedOptions.addAll(widget.selectedVariant!.selectedOptions);
    } else if (widget.product.variants.isNotEmpty) {
      final firstVariant = widget.product.variants.first;
      _selectedOptions.addAll(firstVariant.selectedOptions);
      widget.onVariantChanged(firstVariant);
    }
  }

  ProductVariant? get _currentVariant {
    try {
      return widget.product.variants.firstWhere(
        (variant) =>
            variant.selectedOptions.entries.every(
              (entry) => _selectedOptions[entry.key] == entry.value,
            ),
      );
    } catch (e) {
      return null;
    }
  }

  // Removed unused _availableOptionValues method as it was not referenced and caused a getter error.

  bool _isOptionAvailable(String optionName, String value) {
    final testOptions = Map<String, String>.from(_selectedOptions);
    testOptions[optionName] = value;
    
    return widget.product.variants.any(
      (variant) => variant.selectedOptions.entries.every(
        (entry) => testOptions[entry.key] == entry.value,
      ),
    );
  }

  void _onOptionSelected(String optionName, String value) {
    setState(() {
      _selectedOptions[optionName] = value;
    });

    final variant = _currentVariant;
    if (variant != null) {
      widget.onVariantChanged(variant);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.variants.isEmpty) {
      return const SizedBox.shrink();
    }

    // Extract available options from variants
    final availableOptions = _extractAvailableOptions();

    if (availableOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected Variant Price and Stock
        if (_currentVariant != null) ...[
          Row(
            children: [
              // Price
              Text(
                '\$${_currentVariant!.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              
              SizedBox(width: SizeConfig.getProportionateScreenWidth(16)),
              
              // Compare at price
              if (_currentVariant!.compareAtPrice != null &&
                  _currentVariant!.compareAtPrice! > _currentVariant!.price)
                Text(
                  '\$${_currentVariant!.compareAtPrice!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(16),
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              
              const Spacer(),
              
              // Stock status
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateScreenWidth(8),
                  vertical: SizeConfig.getProportionateScreenHeight(4),
                ),
                decoration: BoxDecoration(
                  color: _currentVariant!.available 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _currentVariant!.available ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontSize: SizeConfig.getProportionateScreenWidth(12),
                    fontWeight: FontWeight.w600,
                    color: _currentVariant!.available ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: SizeConfig.getProportionateScreenHeight(16)),
        ],
        
        // Option Selectors
        ...availableOptions.entries.map((entry) {
          return _buildOptionSelector(entry.key, entry.value);
        }).toList(),
      ],
    );
  }

  Map<String, List<String>> _extractAvailableOptions() {
    final options = <String, Set<String>>{};
    
    for (final variant in widget.product.variants) {
      for (final option in variant.selectedOptions.entries) {
        options[option.key] ??= <String>{};
        options[option.key]!.add(option.value);
      }
    }
    
    return options.map((key, value) => MapEntry(key, value.toList()));
  }

  Widget _buildOptionSelector(String optionName, List<String> availableValues) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.getProportionateScreenHeight(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            optionName,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
          
          Wrap(
            spacing: SizeConfig.getProportionateScreenWidth(8),
            runSpacing: SizeConfig.getProportionateScreenHeight(8),
            children: availableValues.map((value) {
              final isSelected = _selectedOptions[optionName] == value;
              final isAvailable = _isOptionAvailable(optionName, value);
              
              return _buildOptionChip(
                value: value,
                isSelected: isSelected,
                isAvailable: isAvailable,
                onTap: isAvailable
                    ? () => _onOptionSelected(optionName, value)
                    : null,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionChip({
    required String value,
    required bool isSelected,
    required bool isAvailable,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(16),
          vertical: SizeConfig.getProportionateScreenHeight(8),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : (isAvailable ? Colors.grey[100] : Colors.grey[50]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : (isAvailable ? Colors.grey[300]! : Colors.grey[200]!),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(14),
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isAvailable ? Colors.grey[800] : Colors.grey[400]),
          ),
        ),
      ),
    );
  }
}