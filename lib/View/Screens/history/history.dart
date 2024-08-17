import 'dart:convert';

import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/controller/chat_gpt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final ChatGPTController chatGPTController = Get.find<ChatGPTController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64.h,
        title: const CustomText(
          color: AppColors.black_500,
          text: AppString.history,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: chatGPTController.tempValue.length,
          itemBuilder: (context, index) {
            var data = chatGPTController.tempValue[index];

            Map<String, dynamic> decodedValue = jsonDecode(data);
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.purple_400),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: decodedValue["que"],
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    bottom: 10,
                  ),
                  CustomText(
                    text: decodedValue["ans"].join(","),
                    maxLines: 100,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
