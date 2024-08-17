import 'dart:async';

import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Helper/shared_preferences.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppImages/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() async {
    bool? onboard = await SharePrefsHelper.getBool(AppConstants.onBoard);

    Timer(const Duration(seconds: 3), () {
      if (onboard == null || onboard == true) {
        Get.offAllNamed(AppRoute.onBoardingScreen);
      } else {
        Get.offNamed(AppRoute.homePage);
      }
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple_500,
      body: Center(
        child: Container(
          height: 160.h,
          width: 160.w,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImage.appLogo),
          )),
        ),
      ),
    );
  }
}
