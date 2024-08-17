import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomElevatedButton/custom_button.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/View/Widget/CustomTextFeild/custom_text_feild.dart';
import 'package:filtrate/View/Widget/custom_loader/loader.dart';
import 'package:filtrate/controller/admob_controller.dart';
import 'package:filtrate/controller/chat_gpt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatGPtScreen extends StatelessWidget {
  ChatGPtScreen({super.key});

  final ChatGPTController chatGPTController = Get.find<ChatGPTController>();

  final AdMobController adMobController = Get.find<AdMobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.only(top: 64.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppString.searchByTag,
                color: AppColors.purple_500,
                fontWeight: FontWeight.w600,
                fontSize: 24.w,
              ),

              ///<=======================================tab bar========================================>

              SingleChildScrollView(
                padding: EdgeInsets.only(top: 24.h),
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      chatGPTController.cetegary.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            chatGPTController.currentIndex.value = index;
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: index == 2 ? 0.w : 14.w,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(
                                  width: 1.w, color: AppColors.purple_200),
                              color:
                                  chatGPTController.currentIndex.value != index
                                      ? Colors.transparent
                                      : AppColors.purple_500,
                            ),
                            child: CustomText(
                              text: chatGPTController.cetegary[index],
                              fontWeight: FontWeight.w400,
                              fontSize: 14.r,
                              color:
                                  chatGPTController.currentIndex.value != index
                                      ? AppColors.purple_500
                                      : AppColors.whiteColor,
                            ),
                          ),
                        );
                      },
                    )),
              ),

              //<<<<=========================================ADD Tag============================>>>>>>>>>>

              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Row(
                  children: [
                    ///<<<<================================Tag Textediting Controller======================>>>>

                    Expanded(
                      child: CustomTextField(
                        padding: false,
                        textInputAction: TextInputAction.done,
                        textEditingController:
                            chatGPTController.tagController.value,
                        hintText: AppString.addTag,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),

                    //<<<<=========================================ADD Button============================>>>>>>>>>>

                    FloatingActionButton(
                      heroTag: "add Button",
                      backgroundColor: AppColors.purple_400,
                      elevation: 2,
                      onPressed: () {
                        if (chatGPTController
                            .tagController.value.text.isNotEmpty) {
                          chatGPTController.updateTagListText(
                              tagValue:
                                  chatGPTController.tagController.value.text);
                        }
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),

                    SizedBox(
                      width: 10.w,
                    ),

                    FloatingActionButton(
                      heroTag: "Category Button",
                      backgroundColor: AppColors.purple_400,
                      elevation: 2,
                      onPressed: () {
                        Get.toNamed(AppRoute.moreCategory);
                      },
                      child: const Icon(
                        Icons.category_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              if (chatGPTController.tagList.isNotEmpty)

                //<<<<=========================================Tag List============================>>>>>>>>>>

                Expanded(
                  child: GridView.builder(
                    itemCount: chatGPTController.tagList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 50.w, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          //========================Show Added Tag====================
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                    width: 1.w, color: AppColors.purple_200),
                                color: AppColors.purple_500,
                              ),
                              child: CustomText(
                                  fontSize: 12.w,
                                  maxLines: 3,
                                  color: AppColors.whiteColor,
                                  text: chatGPTController.tagList[index]),
                            ),
                          ),

                          //========================Remove Tag====================

                          IconButton(
                              onPressed: () {
                                chatGPTController.tagList
                                    .remove(chatGPTController.tagList[index]);

                                chatGPTController.tagList.refresh();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      );
                    },
                  ),
                ),
              if (chatGPTController.tagList.isEmpty)
                const Expanded(child: SizedBox()),

              //<<<<========================================= Search Button ============================>>>>>>>>>>

              chatGPTController.isloading.value ||
                      adMobController.isFullPage.value
                  ? const CustomLoader()
                  : CustomElevatedButton(
                      onTap: () {
                        adMobController.initializeFullPageAd(
                          adsCloseOnTap: () {
                            chatGPTController.sendReqChatGpt();
                          },
                        );
                      },
                      text: AppString.search,
                    )
            ],
          ),
        );
      }),
    );
  }
}
