import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // 🎨 Banner data — image + text + color
  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'New Arrivals 🌸',
      'subtitle': 'Fresh styles just landed',
      'color': AppColors.mutedPink,
      'image': 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800',
    },
    {
      'title': 'Summer Sale 🌞',
      'subtitle': 'Up to 50% off selected items',
      'color': AppColors.softRose,
      'image': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
    },
    {
      'title': 'Kids Collection 👧',
      'subtitle': 'Cute & comfortable styles',
      'color': AppColors.blushPink,
      'image': 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=800',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Auto-slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Sliding Banner ─────────────────────
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(banner['image']),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        banner['color'].withOpacity(0.5),
                        BlendMode.srcOver,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black26)
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          banner['subtitle'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black26)
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              color: AppColors.mutedPink,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── Dot Indicators ─────────────────────
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.mutedPink
                    : AppColors.blushPink,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}