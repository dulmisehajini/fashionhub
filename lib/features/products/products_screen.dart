import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = 'All';
  String _sortBy = 'Newest';

  // 🛍️ Dummy products — replaced with API on Day 5
  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': '1',
      'name': 'Floral Midi Dress',
      'price': 4500.0,
      'category': 'Women',
      'image': 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=400',
      'isNew': true,
    },
    {
      'id': '2',
      'name': 'Casual Linen Shirt',
      'price': 2800.0,
      'category': 'Men',
      'image': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400',
      'isNew': true,
    },
    {
      'id': '3',
      'name': 'Kids Sunny Dress',
      'price': 1900.0,
      'category': 'Kids',
      'image': 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=400',
      'isNew': false,
    },
    {
      'id': '4',
      'name': 'Elegant Blazer',
      'price': 6500.0,
      'category': 'Women',
      'image': 'https://images.unsplash.com/photo-1594938298603-c8148c4a8b8f?w=400',
      'isNew': false,
    },
    {
      'id': '5',
      'name': 'Slim Fit Chinos',
      'price': 3200.0,
      'category': 'Men',
      'image': 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=400',
      'isNew': false,
    },
    {
      'id': '6',
      'name': 'Pleated Skirt',
      'price': 2100.0,
      'category': 'Women',
      'image': 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=400',
      'isNew': true,
    },
    {
      'id': '7',
      'name': 'Kids Denim Jacket',
      'price': 2600.0,
      'category': 'Kids',
      'image': 'https://images.unsplash.com/photo-1522771930-78848d9293e8?w=400',
      'isNew': false,
    },
    {
      'id': '8',
      'name': 'Silk Blouse',
      'price': 3800.0,
      'category': 'Women',
      'image': 'https://images.unsplash.com/photo-1564257631407-4deb1f99d992?w=400',
      'isNew': true,
    },
  ];

  // Filter products by selected category
  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = _selectedCategory == 'All'
        ? _allProducts
        : _allProducts
            .where((p) => p['category'] == _selectedCategory)
            .toList();

    // Sort
    if (_sortBy == 'Price: Low to High') {
      filtered.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (_sortBy == 'Price: High to Low') {
      filtered.sort((a, b) => b['price'].compareTo(a['price']));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Shop'),
        actions: [
          // Sort button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: AppColors.deepCharcoal),
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder: (context) => [
              'Newest',
              'Price: Low to High',
              'Price: High to Low',
            ]
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Category Filter Tabs ─────────────
          Container(
            color: AppColors.white,
            child: _buildCategoryTabs(),
          ),

          // ── Results Count ────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} items',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Text(
                  'Sort: $_sortBy',
                  style: TextStyle(
                    color: AppColors.mutedPink,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── Product Grid ─────────────────────
          Expanded(
            child: _filteredProducts.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: _filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ── Category Tab Bar ───────────────────────
  Widget _buildCategoryTabs() {
    final categories = ['All', 'Women', 'Men', 'Kids'];
    return Row(
      children: categories.map((cat) {
        final bool isSelected = _selectedCategory == cat;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColors.mutedPink
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                cat,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.mutedPink
                      : Colors.grey.shade500,
                  fontWeight: isSelected
                      ? FontWeight.w700
                      : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Empty State ────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.blushPink),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different category',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}