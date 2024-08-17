import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CetegaryCard extends StatelessWidget {
  const CetegaryCard(
      {super.key, required this.title, this.onTap, required this.icon});
  final String icon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(builder: (controller) {
      return Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(width: 1.w, color: AppColors.purple_300),
              ),

              ///<================================cetegary Card=======================================>

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black_500,
                    text: title,
                  ),
                  SvgPicture.asset(icon),
                ],
              ),
            ),
          ),

          ///<====================================Gener Part============================================>
        ],
      );
    });
  }
}
