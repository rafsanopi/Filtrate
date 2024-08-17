import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onTap, this.text = AppString.getStarted});
  final Function()? onTap;

  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.purple_500,
          gradient: const LinearGradient(
            begin: Alignment(0.77, 0.64),
            end: Alignment(-0.90, 0.64),
            colors: [
              Color(0xFF2E2451),
              Color(0xFF7668A9),
            ],
          ),
        ),
        child: CustomText(
          fontWeight: FontWeight.w600,
          fontSize: 18.h,
          text: text,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
