import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  bool _isWishlisted = false;

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];
  final List<Color> _colors = [
    const Color(0xFF2C2C2C),  // Charcoal
    const Color(0xFFD98CA6),  // Muted Pink
    const Color(0xFFFFFFFF),  // White
    const Color(0xFF8B6914),  // Brown
    const Color(0xFF1A237E),  // Navy
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          // ── Image App Bar ──────────────────────
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppColors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.deepCharcoal,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isWishlisted ? Icons.favorite : Icons.favorite_outline,
                    color: _isWishlisted ? AppColors.mutedPink : Colors.grey,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.product['image'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.blushPink,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mutedPink,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Product Info ───────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Name + Price ───────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepCharcoal,
                          ),
                        ),
                      ),
                      Text(
                        'LKR ${widget.product['price'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.mutedPink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ── Category badge ─────────────
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blushPink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.product['category'],
                      style: const TextStyle(
                        color: AppColors.mutedPink,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Color Selector ─────────────
                  const Text(
                    'Select Color',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepCharcoal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _colors.map((color) {
                      final bool isSelected = _selectedColor == color.toString();
                      return GestureDetector(
                        onTap: () => setState(
                          () => _selectedColor = color.toString(),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mutedPink
                                  : Colors.grey.shade300,
                              width: isSelected ? 3 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // ── Size Selector ──────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepCharcoal,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Size Guide',
                          style: TextStyle(color: AppColors.mutedPink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: _sizes.map((size) {
                      final bool isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.mutedPink
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mutedPink
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.deepCharcoal,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // ── Quantity ───────────────────
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepCharcoal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (_quantity > 1) {
                            setState(() => _quantity--);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepCharcoal,
                          ),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Bottom Add to Cart Bar ───────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Total price
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  'LKR ${(widget.product['price'] * _quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mutedPink,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Add to cart button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a size!'),
                        backgroundColor: AppColors.mutedPink,
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.product['name']} added to cart!',
                      ),
                      backgroundColor: AppColors.mutedPink,
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quantity Button Widget ─────────────────────
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.blushPink,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.mutedPink, size: 20),
      ),
    );
  }
}