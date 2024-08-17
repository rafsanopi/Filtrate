import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/controller/chat_gpt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MoreCategory extends StatelessWidget {
  MoreCategory({super.key});

  final ChatGPTController controller = Get.find<ChatGPTController>();

  Widget cardDesign(
          {required String title,
          double vertical = 15,
          double marginLeft = 0,
          double marginRight = 0,
          String isMainCategory = AppString.mainCategory,
          int mainIndex = 0,
          required VoidCallback ontap,
          double horizontal = 10}) =>
      GestureDetector(
        onTap: () {
          ontap();
        },
        child: Container(
          margin:
              EdgeInsets.only(bottom: 10, left: marginLeft, right: marginRight),
          padding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.black_100),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///======================== Name of the category =========================

              Expanded(
                  child: CustomText(
                textAlign: TextAlign.left,
                text: title,
                maxLines: 2,
              )),

              ///======================== Main Category Dropdown =========================

              if (isMainCategory == AppString.mainCategory)
                Icon(
                    size: 30.r,
                    controller.isCategoryExpanded[mainIndex] != true
                        ? Icons.keyboard_arrow_right_rounded
                        : Icons.keyboard_arrow_down_rounded),

              ///======================== Sub Category Dropdown =========================

              if (isMainCategory == AppString.subCategory)
                Icon(size: 30.r, Icons.keyboard_arrow_right_rounded),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const CustomText(
          text: AppString.moreCategories,
          fontSize: 20,
        )),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ///===================== Movie and Tv Shows Button===================
                cardDesign(
                    ontap: () {
                      controller.isCategoryExpanded[0] =
                          !controller.isCategoryExpanded[0];

                      controller.isCategoryExpanded.refresh();
                    },
                    title: controller.categoryModel.value.data![0].title ?? ""),

                ///================== Movie and Tv Shows Category ====================

                if (controller.isCategoryExpanded[0] == true)
                  Column(
                    children: List.generate(
                        controller.categoryModel.value.data![0].data!.length,
                        (index) {
                      var data =
                          controller.categoryModel.value.data![0].data![index];
                      return cardDesign(
                          ontap: () {
                            Get.toNamed(AppRoute.chooseFinalCategories,
                                arguments: [data.subData, data.subtitle]);
                          },
                          isMainCategory: AppString.subCategory,
                          vertical: 8,
                          marginRight: 40,
                          title: data.subtitle ?? "");
                    }),
                  ),

                ///===================== Music Button ===================
                cardDesign(
                    ontap: () {
                      controller.isCategoryExpanded[1] =
                          !controller.isCategoryExpanded[1];

                      controller.isCategoryExpanded.refresh();
                    },
                    mainIndex: 1,
                    title: controller.categoryModel.value.data![1].title ?? ""),

                ///================== Music Category ====================

                if (controller.isCategoryExpanded[1] == true)
                  Column(
                    children: List.generate(
                        controller.categoryModel.value.data![1].data!.length,
                        (index) {
                      var data =
                          controller.categoryModel.value.data![1].data![index];
                      return cardDesign(
                          ontap: () {
                            Get.toNamed(AppRoute.chooseFinalCategories,
                                arguments: [data.subData, data.subtitle]);
                          },
                          isMainCategory: AppString.subCategory,
                          vertical: 8,
                          marginRight: 40,
                          title: data.subtitle ?? "");
                    }),
                  ),
              ],
            ),
          );
        }));
  }
}
