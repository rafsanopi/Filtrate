import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/controller/home_controller.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchByCetegary extends StatelessWidget {
  SearchByCetegary({super.key});

  final dynamic gerne = Get.arguments[0];

  final APIStatus status = Get.arguments[1];

  final FilterController searchController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
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
                      onTap: () {
                        searchController.clearMovieCheckBox();
                        searchController.clearTvSeriesCheckBox();
                      },
                      child: const CustomText(
                        text: AppString.clear,
                        color: AppColors.purple_500,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 49.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: gerne.length,
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // controller.current = index;
                          // controller.update();
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //====================================Check Box=================================

                                Checkbox(
                                  activeColor: AppColors.purple_500,
                                  side: const BorderSide(
                                      color: AppColors.black_50),
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.r)),

                                  //<<<<<<<<<===============SHow Genre List================>>>>>>>

                                  value: status == APIStatus.movie
                                      ? controller.movieCheckedList[index]
                                      : status == APIStatus.tvSeries
                                          ? controller
                                              .tvSeriesCheckedList[index]
                                          : controller
                                              .musicGenreCheckedList[index],
                                  onChanged: (value) {
                                    //==============Update the checked state for the corresponding checkbox=============

                                    status == APIStatus.movie
                                        ? controller.movieCheckedList[index] =
                                            value!
                                        : status == APIStatus.tvSeries
                                            ? controller.tvSeriesCheckedList[
                                                index] = value!
                                            : controller.musicGenreCheckedList[
                                                index] = value!;

                                    //=================Save the checked Genre in a List=================

                                    if (value) {
                                      if (status == APIStatus.movie) {
                                        controller.selectedMovieGenre
                                            .add(gerne[index].id!);
                                      } else if (status == APIStatus.tvSeries) {
                                        controller.selectedtvSeriesGenre
                                            .add(gerne[index].id!);
                                      } else {
                                        controller.selectedMusicGenre
                                            .add(gerne[index].name!);
                                      }
                                    } else {
                                      if (status == APIStatus.movie) {
                                        controller.selectedMovieGenre
                                            .remove(gerne[index].id);
                                      } else if (status == APIStatus.tvSeries) {
                                        controller.selectedtvSeriesGenre
                                            .remove(gerne[index].id);
                                      } else {
                                        controller.selectedMusicGenre
                                            .remove(gerne[index].name!);
                                      }
                                    }

                                    debugPrint(
                                        "selectedMusicGenre^^^^^^^^^^^^.......========>>>>>${controller.selectedMusicGenre}");

                                    controller.update();
                                  },
                                ),
                                SizedBox(width: 8.w),
                                CustomText(text: gerne[index].name!),
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
                    },
                  ),
                ),

                //<<<<<<<<====================================Apply Button==============================>>>>>>>>>

                GestureDetector(
                  onTap: () {
                    if (status == APIStatus.movie) {
                      searchController.filterMovie();
                    } else if (status == APIStatus.tvSeries) {
                      searchController.filterTvSeries();
                    } else {
                      searchController.filterMusic();
                    }
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.purple_500,
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
        ),
      );
    });
  }
}
