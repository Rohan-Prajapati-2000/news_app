import 'package:flutter/material.dart';

import '../../../utils/circular_container.dart';
import '../../../utils/constants/sizes.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key, required this.image, required this.title, required this.onTap,
  });

  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SRoundedContainer(
            height: 180,
            width: 180,
            backgroundColor: Colors.blue,
            radius: SSizes.borderRadiusSm,
          ),
          Positioned.fill(
            child: Image.asset(image, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
