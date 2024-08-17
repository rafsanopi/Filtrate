import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GennerCard extends StatelessWidget {
  const GennerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 16.h),
        decoration: const BoxDecoration(
          color: AppColors.purple_50,
          boxShadow: [
            BoxShadow(
              color: Color(0x261B1B1B),
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: List.generate(controller.gener.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.current = index;
                controller.update();
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.purple_500,
                        side: const BorderSide(color: AppColors.whiteColor),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2.r)),
                        value: controller.isCheckedList[index],
                        onChanged: (value) {
                          // Toggle the checked state for the corresponding checkbox
                          controller.isCheckedList[index] = value!;
                          //  controller.isCheaked = isCheckedList[index];
                          controller.update();
                        },
                      ),
                      SizedBox(width: 8.w),
                      CustomText(text: controller.gener[index]),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    height: 1.h,
                    color: AppColors.purple_100,
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
