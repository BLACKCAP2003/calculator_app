import 'package:calculator_app/src/data/models/letter.dart';
import 'package:calculator_app/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget(
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
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: MediaQuery.of(context).devicePixelRatio * 18,
            width: MediaQuery.of(context).devicePixelRatio * 18,
            padding: title == 'reload'
                ? const EdgeInsets.all(12)
                : const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade100,
                ),
              ],
            ),
            child: SvgPicture.asset(
              Letter.getAsset(title),
              width: MediaQuery.of(context).devicePixelRatio * 9,
              height: MediaQuery.of(context).devicePixelRatio * 9,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
