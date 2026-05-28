import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String _selected = 'All';

  final List<Map<String, dynamic>> _categories = [
    {'label': 'All',   'icon': Icons.grid_view_rounded},
    {'label': 'Women', 'icon': Icons.woman_outlined},
    {'label': 'Men',   'icon': Icons.man_outlined},
    {'label': 'Kids',  'icon': Icons.child_care_outlined},
    {'label': 'Sale',  'icon': Icons.local_offer_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final bool isSelected = _selected == cat['label'];
          return GestureDetector(
            onTap: () => setState(() => _selected = cat['label']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mutedPink : AppColors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.mutedPink : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(
                        color: AppColors.mutedPink.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(
                    cat['icon'],
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.deepCharcoal,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}