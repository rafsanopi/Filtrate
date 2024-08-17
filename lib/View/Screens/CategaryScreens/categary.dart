import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';

class CetegaryPage extends StatefulWidget {
  const CetegaryPage({super.key});

  @override
  State<CetegaryPage> createState() => _CetegaryPageState();
}

class _CetegaryPageState extends State<CetegaryPage> {
  List<String> item = [
    AppString.termsAndCondition,
    AppString.aboutUs,
    AppString.history,
    AppString.rateThisApp,
  ];
  int currentrIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              Column(
                children: List.generate(item.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      currentrIndex = index;
                      currentrIndex == 0
                          ? Get.toNamed(AppRoute.termsAndCondition)
                          : currentrIndex == 1
                              ? Get.toNamed(AppRoute.aboutUs)
                              : currentrIndex == 2
                                  ? Get.toNamed(AppRoute.history)
                                  : "";

                      if (currentrIndex == 3) {
                        final InAppReview inAppReview = InAppReview.instance;

                        inAppReview.openStoreListing(
                            appStoreId: '...', microsoftStoreId: '...');
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border:
                            Border.all(width: 1.w, color: AppColors.purple_300),
                      ),

                      ///<================================cetegary Card=======================================>

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (index == 3)
                                const Icon(
                                  Icons.star,
                                  color: AppColors.purple_500,
                                ),
                              CustomText(
                                left: index == 3 ? 10 : 0,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_400,
                                text: item[index],
                              ),
                            ],
                          ),
                          if (index != 3)
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.purple_500,
                            )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
