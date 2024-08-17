import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/controller/chat_gpt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseFinalCategories extends StatefulWidget {
  const ChooseFinalCategories({super.key});

  @override
  State<ChooseFinalCategories> createState() => _ChooseFinalCategoriesState();
}

class _ChooseFinalCategoriesState extends State<ChooseFinalCategories> {
  List<String> subData = Get.arguments[0];

  final String title = Get.arguments[1];

  final ChatGPTController chatGPTController = Get.find<ChatGPTController>();

  @override
  void initState() {
    chatGPTController.subDataBool =
        List.generate(subData.length, (_) => false).obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: CustomText(
          maxLines: 2,
          text: title,
          fontSize: 20,
        )),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          itemCount: subData.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return GestureDetector(
                onTap: () {
                  chatGPTController.subDataBool[index] =
                      !chatGPTController.subDataBool[index];

                  chatGPTController.subDataBool.refresh();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black_100),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///======================= Title ====================
                      CustomText(
                        textAlign: TextAlign.left,
                        text: subData[index],
                        maxLines: 2,
                      ),

                      ///======================= Title ====================

                      Checkbox(
                        activeColor: AppColors.purple_500,
                        side: const BorderSide(color: AppColors.black_50),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2.r)),
                        value: chatGPTController.subDataBool[index],
                        onChanged: (value) {
                          chatGPTController.subDataBool[index] =
                              !chatGPTController.subDataBool[index];
                          chatGPTController.subDataBool.refresh();
                          chatGPTController.updateTagListCategory(
                              tagValue: subData[index]);

                          debugPrint("${chatGPTController.tagList}");
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ));
  }
}
