import 'package:filtrate/Helper/network_image.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/View/Widget/CustomTextFeild/custom_text_feild.dart';
import 'package:filtrate/View/Widget/custom_loader/loader.dart';
import 'package:filtrate/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final List<String> cetegary = [
    AppString.all,
    AppString.music,
    AppString.moviesAndTvSeries,
  ];

  final MySearchController controller = Get.find<MySearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Obx(() {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 11.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0A1B1B1B),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///<===============================Search Field================================>
                          Expanded(
                            child: CustomTextField(
                              onFieldSubmitted: (value) {
                                if (controller.searchTextEditingController.value
                                    .text.isNotEmpty) {
                                  controller.searchedResult.value = [];
                                  controller.searchedMovieList.value = [];
                                  controller.searchedMusicList.value = [];
                                  controller.conbineSearch();
                                }
                              },
                              textInputAction: TextInputAction.search,
                              textEditingController:
                                  controller.searchTextEditingController.value,
                              prefixIcon: SvgPicture.asset(
                                AppIcons.searchIcon,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.searchTextEditingController.value
                                      .clear();
                                  controller.searchIs.value =
                                      false; //!controller.searchIs;
                                  controller.searchIs.refresh();
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: AppColors.crossButtonColor,
                                ),
                              ),
                              hintText: AppString.search,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16.h),
                              padding: true,
                              fieldBorderRadius: 4.r,
                              fieldBorderColor: AppColors.purple_200,
                            ),
                          ),
                          // SizedBox(
                          //   width: 12.w,
                          // ),

                          ///<=================================Filter Icon================================>

                          // GestureDetector(
                          //   onTap: () {
                          //     Get.toNamed(AppRoute.choseCetegaryScreen);
                          //   },
                          //   child: SvgPicture.asset(
                          //     AppIcons.filterIocn,
                          //     colorFilter: const ColorFilter.mode(
                          //         AppColors.black_200, BlendMode.srcIn),
                          //     height: 24.h,
                          //     width: 22.w,
                          //   ),
                          // ),
                        ],
                      ),

                      ///<============================tab bar========================================================>
                      controller.searchIs.value
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                cetegary.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.currentIndex.value = index;
                                      controller.update();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 16.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.r),
                                        border: Border.all(
                                            width: 1.w,
                                            color:
                                                controller.currentIndex.value !=
                                                        index
                                                    ? AppColors.purple_200
                                                    : Colors.transparent),
                                        color: controller.currentIndex.value !=
                                                index
                                            ? Colors.transparent
                                            : AppColors.purple_500,
                                      ),
                                      child: CustomText(
                                        text: cetegary[index],
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: controller.currentIndex.value !=
                                                index
                                            ? AppColors.purple_500
                                            : AppColors.whiteColor,
                                      ),
                                    ),
                                  );
                                },
                              )),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),

              ///<===================================Main  Body===========================================================>
              ///
              SizedBox(
                height: 24.h,
              ),
              controller.searchIs.value
                  ? Obx(() {
                      switch (controller.rxRequestStatus.value) {
                        case Status.loading:
                          return Padding(
                            padding: EdgeInsets.only(top: 120.h),
                            child: const CustomLoader(),
                          );
                        case Status.internetError:
                          return const CustomLoader();
                        case Status.error:
                          return const CustomLoader();
                        case Status.completed:
                          return Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.currentIndex.value == 0
                                  ? controller.searchedResult.length
                                  : controller.currentIndex.value == 1
                                      ? controller.searchedMusicList.length
                                      : controller.searchedMovieList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                dynamic data;
                                if (controller.currentIndex.value == 0) {
                                  data = controller.searchedResult[index];
                                } else if (controller.currentIndex.value == 1) {
                                  data = controller.searchedMusicList[index];
                                } else {
                                  data = controller.searchedMovieList[index];
                                }

                                return Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: AppColors.purple_50),
                                  child: Row(children: [
                                    ///<==================================Image Card=================================>

                                    CustomNetworkImage(
                                      imageUrl: data.image,
                                      height: 92.h,
                                      width: 66.w,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),

                                    ///<==============================Movie Name======================================>
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            bottom: 4.h,
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: data.title,
                                            color: AppColors.purple_500,
                                            fontSize: 14.w,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///<===========================Movie Type===========================>
                                              // CustomText(
                                              //   right: 4.w,
                                              //   fontSize: 12.h,
                                              //   fontWeight: FontWeight.w400,
                                              //   color: AppColors.purple_500,
                                              //   text: data.genre,
                                              // ),

                                              ///<========================StarIcon================================>
                                              // SvgPicture.asset(
                                              //   AppIcons.starIcon,
                                              //   colorFilter:
                                              //       const ColorFilter.mode(
                                              //     AppColors.yellow_500,
                                              //     BlendMode.srcIn,
                                              //   ),
                                              //   height: 10.h,
                                              //   width: 10.w,
                                              // ),

                                              ///<==========================AllRatting==========================>
                                              CustomText(
                                                text: data.rating,
                                                color: AppColors.black_500,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                );
                              },
                            ),
                          );
                      }
                    })

                  //

                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
