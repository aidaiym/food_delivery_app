import 'package:flutter/material.dart';

import '../../../export_files.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget(
    this.categories, {
    super.key,
  });
  final List<Category> categories;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          Category category = widget.categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DishView(
                      category: category,
                    ),
                  ),
                );
              },
              child: Center(
                child: Stack(
                  children: [
                    Image.network(
                      category.imageUrl,
                      width: 353,
                      height: 158,
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child:
                          Text(category.name, style: AppTextStyles.headline2),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
