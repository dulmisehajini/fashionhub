import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Floral Midi Dress',
      'price': 4500.0,
      'size': 'M',
      'color': 'Pink',
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=400',
    },
    {
      'id': '2',
      'name': 'Casual Linen Shirt',
      'price': 2800.0,
      'size': 'L',
      'color': 'White',
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400',
    },
    {
      'id': '3',
      'name': 'Elegant Blazer',
      'price': 6500.0,
      'size': 'S',
      'color': 'Charcoal',
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=400',
    },
  ];

  double get _total => _cartItems.fold(
        0,
        (sum, item) => sum + (item['price'] * item['quantity']),
      );

  double get _deliveryFee => _total > 5000 ? 0 : 350;
  double get _grandTotal => _total + _deliveryFee;

  void _increaseQuantity(int index) {
    setState(() => _cartItems[index]['quantity']++);
  }

  void _decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      setState(() => _cartItems[index]['quantity']--);
    }
  }

  void _removeItem(int index) {
    final name = _cartItems[index]['name'];
    setState(() => _cartItems.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed from cart'),
        backgroundColor: AppColors.mutedPink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: Text('My Cart (${_cartItems.length})'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                if (_deliveryFee > 0)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16,
                    ),
                    color: AppColors.blushPink,
                    child: Text(
                      'Add LKR ${(5000 - _total).toStringAsFixed(0)} more for FREE delivery!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.mutedPink,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16,
                    ),
                    color: AppColors.blushPink,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_shipping_outlined,
                          color: AppColors.mutedPink, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'You got FREE delivery!',
                          style: TextStyle(
                            color: AppColors.mutedPink,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return _CartItem(
                        item: _cartItems[index],
                        onIncrease: () => _increaseQuantity(index),
                        onDecrease: () => _decreaseQuantity(index),
                        onRemove: () => _removeItem(index),
                      );
                    },
                  ),
                ),
                _buildOrderSummary(),
              ],
            ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Subtotal',
            value: 'LKR ${_total.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'Delivery',
            value: _deliveryFee == 0 ? 'FREE' : 'LKR ${_deliveryFee.toStringAsFixed(0)}',
            valueColor: _deliveryFee == 0 ? Colors.green : null,
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepCharcoal,
                ),
              ),
              Text(
                'LKR ${_grandTotal.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mutedPink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Proceeding to checkout — Day 6 builds this!'),
                  backgroundColor: AppColors.mutedPink,
                ),
              );
            },
            child: const Text('Proceed to Checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined,
            size: 80, color: AppColors.blushPink),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.deepCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to get started',
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const _CartItem({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.softRose.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.deepCharcoal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Size: ${item['size']} • ${item['color']}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LKR ${(item['price'] * item['quantity']).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.mutedPink,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        _QtyBtn(icon: Icons.remove, onTap: onDecrease),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${item['quantity']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        _QtyBtn(icon: Icons.add, onTap: onIncrease),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.blushPink,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: AppColors.mutedPink),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.deepCharcoal,
          ),
        ),
      ],
    );
  }
}