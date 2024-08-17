import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomSnackBar(String? message,
    {bool isError = true, bool getXSnackBar = false}) {
  if (message != null && message.isNotEmpty) {
    if (getXSnackBar) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: isError ? AppColors.purple_50 : Colors.blue,
        message: message,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: EdgeInsets.all(10.sp),
        borderRadius: 8.r,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.only(
          right: 20.h,
          top: 10.h,
          bottom: 10.h,
          left: 20.h,
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: isError ? AppColors.purple_50 : Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        content: CustomText(text: message),
      ));
    }
  }
}

//
void toastMessage({required String message}) {
  Fluttertoast.showToast(
    
    msg: message,
    backgroundColor: AppColors.whiteColor,
    textColor: AppColors.black_500,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}
