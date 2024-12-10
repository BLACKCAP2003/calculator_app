import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.color});

  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).devicePixelRatio * 18,
            width: MediaQuery.of(context).devicePixelRatio * 18,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: MediaQuery.of(context).devicePixelRatio * 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
