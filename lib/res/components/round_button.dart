import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color, textColor;
  final bool isLoading;

  const RoundButton({
    Key? key,
    this.isLoading = false,
    required this.title,
    required this.onPressed,
    this.color = AppColors.whiteColor,
    this.textColor = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading? null : onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryMaterialColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child:isLoading? const CircularProgressIndicator(color: Colors.white,): Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 22, color: color),
          ),
        ),
      ),

    );
  }
}
