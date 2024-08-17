import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomImage/custom_image.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatGptResponse extends StatelessWidget {
  ChatGptResponse({super.key});

  final List<dynamic> response = Get.arguments[0];

  final String input = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: AppString.response,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomImage(imageSrc: AppIcons.selectedAI),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.black_100)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(response.length, (index) {
                      return CustomText(
                        maxLines: 100,
                        textAlign: TextAlign.left,
                        text: response[index],
                        bottom: 10,
                        fontSize: 16,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.black_100)),
              padding: const EdgeInsets.all(10),
              child: CustomText(
                  textAlign: TextAlign.left, maxLines: 100, text: input),
            )));
  }
}
