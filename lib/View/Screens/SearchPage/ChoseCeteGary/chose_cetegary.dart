import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:filtrate/View/Screens/SearchPage/cetegary_card.dart';
import 'package:filtrate/View/Screens/SearchPage/genner_card.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChoseCetegaryPage extends StatelessWidget {
  const ChoseCetegaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FilterController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///<=============================Cancel Text================================>

                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const CustomText(
                        text: AppString.cancel,
                        color: AppColors.black_500,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),

                    ///<=============================Clear Text================================>
                    GestureDetector(
                      onTap: () {},
                      child: const CustomText(
                        text: AppString.clear,
                        color: AppColors.black_200,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 41.h,
                ),

                ///<=============================Movie===============================>

                Column(
                  children: [
                    CetegaryCard(
                      title: AppString.movies,
                      onTap: () {
                        controller.movieExpened = !controller.movieExpened;
                        controller.update();
                      },
                      icon: controller.movieExpened == true
                          ? AppIcons.minusIcon
                          : AppIcons.plusIocn,
                    ),
                    controller.movieExpened == true
                        ? const GennerCard()
                        : SizedBox(
                            height: 8.h,
                          ),
                  ],
                ),

                ///<=============================Tv series===============================>
                Column(
                  children: [
                    CetegaryCard(
                      title: AppString.tVSeries,
                      onTap: () {
                        controller.tvExpened = !controller.tvExpened;
                        controller.update();
                      },
                      icon: controller.tvExpened == true
                          ? AppIcons.minusIcon
                          : AppIcons.plusIocn,
                    ),
                    controller.tvExpened == true
                        ? const GennerCard()
                        : SizedBox(
                            height: 8.h,
                          ),
                  ],
                ),

                ///<=============================Music===============================>
                Column(
                  children: [
                    CetegaryCard(
                      title: AppString.music,
                      onTap: () {
                        controller.musicExpened = !controller.musicExpened;
                        controller.update();
                      },
                      icon: controller.musicExpened == true
                          ? AppIcons.minusIcon
                          : AppIcons.plusIocn,
                    ),
                    controller.musicExpened == true
                        ? const GennerCard()
                        : SizedBox(
                            height: 8.h,
                          ),
                  ],
                ),

                SizedBox(
                  height: 64.h,
                ),

                ///<=============================Apply Button================================>
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.black_200,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: const CustomText(
                      text: AppString.apply,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
