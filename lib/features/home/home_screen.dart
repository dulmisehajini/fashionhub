import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/banner_slider.dart';
import '../../shared/widgets/category_chips.dart';
import '../../shared/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 🛍️ Dummy products — Day 5 we replace with real API data
  static const List<Map<String, dynamic>> _newArrivals = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      
      // ── App Bar ──────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'FashionHub',
              style: TextStyle(
                color: AppColors.mutedPink,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'Sri Lanka\'s Fashion Store',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 10,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.deepCharcoal),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.deepCharcoal),
            onPressed: () {},
          ),
        ],
      ),

      // ── Body ─────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Banner Slider ──────────────────
            const BannerSlider(),
            const SizedBox(height: 24),

            // ── Categories ────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shop by Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepCharcoal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: AppColors.mutedPink),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const CategoryChips(),
            const SizedBox(height: 24),

            // ── New Arrivals ───────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Arrivals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepCharcoal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: AppColors.mutedPink),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Product Grid ───────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _newArrivals.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: _newArrivals[index]);
                },
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}