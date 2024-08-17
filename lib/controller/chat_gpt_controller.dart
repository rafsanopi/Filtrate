import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Helper/shared_preferences.dart';
import 'package:filtrate/Model/category_model.dart';
import 'package:filtrate/Service/api_url.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/ToastSnackBar/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatGPTController extends GetxController {
  final List<String> cetegary = [
    AppString.movies,
    AppString.tVSeries,
    AppString.music,
  ];

  RxInt currentIndex = 0.obs;

  Rx<TextEditingController> tagController = TextEditingController().obs;

  RxList<String> tagList = <String>[].obs;

  RxBool isloading = false.obs;

  //================================== Init OpenAI ===========================

  final openAI = OpenAI.instance.build(
      token: ApiConstant.chatGptAPI,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);

  //==================================Send Req to Chat GPT===========================

  RxList<String> tempValue = <String>[].obs;
  RxMap newHistory = {}.obs;
  void sendReqChatGpt() async {
    if (tagList.isEmpty) {
      toastMessage(message: AppString.pleaseChoose);
    } else {
      isloading.value = true;
      isloading.refresh();
      List<dynamic> choices = [];
      final request = ChatCompleteText(messages: [
        Map.of({
          "role": "user",
          "content":
              "Give me a list of ${cetegary[currentIndex.value]} which contains those tags ${tagList.join(",")}"
        })
      ], maxToken: 100, model: GptTurbo0301ChatModel());

      final response = await openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        choices.add(element.message?.content);
        debugPrint("data ------------------> $choices");
      }

      isloading.value = false;

      refresh();

      updateHistory(choices: choices);

      Get.toNamed(AppRoute.chatGptResponse, arguments: [
        choices,
        "Give me a list of ${cetegary[currentIndex.value]} which contains those tags => ${tagList.join(",")}"
      ]);

      tagList.value = [];
      refresh();
    }
  }

  updateHistory({required List<dynamic> choices}) async {
    ///======================= Setting Value to SharedPref To Show on History ======================
    newHistory.value = {
      AppString.que:
          "Give me a list of ${cetegary[currentIndex.value]} which contains those tags => ${tagList.join(",")}",
      AppString.ans: choices
    };
    newHistory.refresh();

    List<String> getValue =
        await SharePrefsHelper.getLisOfString(AppString.que) ?? [];

    if (getValue.isEmpty) {
      SharePrefsHelper.setListOfString(AppString.que, [jsonEncode(newHistory)]);
      tempValue.value = getValue;
    } else {
      tempValue.value = getValue;

      tempValue.insert(0, jsonEncode(newHistory));

      SharePrefsHelper.setListOfString(AppString.que, tempValue);

      getHistory();
    }
    refresh();
    ////========</>========
  }

  getHistory() async {
    List<String> getValue =
        await SharePrefsHelper.getLisOfString(AppString.que) ?? [];

    if (getValue.isNotEmpty) {
      tempValue.value = getValue;
    }

    debugPrint("Length===$tempValue");
    refresh();
  }

  ///===================== Load More Category from Local Database =======================

  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<bool> isCategoryExpanded = <bool>[false, false].obs;

  RxList<bool> subDataBool = <bool>[].obs;

  loadCategoryJson() async {
    var res = await rootBundle.loadString('assets/category.json');
    categoryModel.value = CategoryModel.fromJson(jsonDecode(res));

    debugPrint(
        "Category Response==================>>>>>>>>${categoryModel.value.message}");
  }

  ///====================== Update Tag List ========================
  updateTagListText({required String tagValue}) {
    if (tagList.contains(tagValue)) {
      toastMessage(message: AppString.tagAlreadyAdded);
    } else {
      tagList.add(tagValue);
      tagController.value.clear();
      refresh();
    }
  }

  updateTagListCategory({required String tagValue}) {
    if (tagList.contains(tagValue)) {
      tagList.remove(tagValue);
    } else {
      tagList.add(tagValue);
    }

    refresh();
  }

  @override
  void onInit() {
    loadCategoryJson();
    getHistory();
    super.onInit();
  }
}
