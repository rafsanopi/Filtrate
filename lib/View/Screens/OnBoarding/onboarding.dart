import 'package:dots_indicator/dots_indicator.dart';
import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Helper/shared_preferences.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppImages/app_image.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomElevatedButton/custom_button.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<String> titleFirstPart = [
    AppString.wellComeToFiltrate,
    AppString.easilyCanFindYour,
    AppString.find
  ];

  List<String> titleSecondPart = [
    AppString.filtrate,
    AppString.musicPlaylist,
    AppString.thatSuitsYou
  ];

  List<String> subTitle = [
    AppString.findYourFavoriteTVMovies,
    AppString.byFilteringYouCanEasily,
    AppString.youCanFindYourSpecific
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(currentIndex == 0
                ? AppImage.banner
                : currentIndex == 1
                    ? AppImage.onboardingTwo
                    : AppImage.onboardingThree),
          ),
        ),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.01, -.8),
                end: const Alignment(0.01, 1.3),
                colors: [
                  Colors.white.withOpacity(0),
                  const Color(0xFF0C0C0C),
                  const Color(0xFF0B0B0B)
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: subTitle.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///<==================================Title=================================================>
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: titleFirstPart[index],
                                          style: TextStyle(
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 32.sp),
                                        ),
                                        TextSpan(
                                          text: " ${titleSecondPart[index]}",
                                          style: TextStyle(
                                              color: AppColors.purple_400,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///<===================================Sub Title=================================================>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomText(
                                  left: 57.w,
                                  right: 57.w,
                                  top: 8.h,
                                  maxLines: 3,
                                  text: subTitle[index],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),

                ///<===================================Doted Indicator=================================================>

                DotsIndicator(
                  dotsCount: subTitle.length,
                  position: currentIndex,
                  decorator: const DotsDecorator(
                    color: AppColors.black_400,
                    activeColor: AppColors.whiteColor,
                    activeSize: Size(12.0, 12.0),
                    size: Size.square(12),
                  ),
                ),

                ///<===================================Get Started Button=================================================>

                CustomElevatedButton(
                  onTap: () {
                    SharePrefsHelper.setBool(AppConstants.onBoard, false);
                    Get.offNamed(AppRoute.homePage);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
