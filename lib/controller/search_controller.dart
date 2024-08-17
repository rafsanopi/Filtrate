import 'package:filtrate/Model/movie_model.dart';
import 'package:filtrate/Model/music_model.dart';
import 'package:filtrate/Service/api_check.dart';
import 'package:filtrate/Service/api_service.dart';
import 'package:filtrate/Service/api_url.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  Rx<TextEditingController> searchTextEditingController =
      TextEditingController().obs;
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final String imageBaseUrl = "https://image.tmdb.org/t/p/w154/";
  RxList<GeneralSearchedModel> searchedResult = <GeneralSearchedModel>[].obs;

  RxBool searchIs = false.obs;
  RxInt currentIndex = 0.obs;

  //====================================Movie and Tv Series Search===============================
  RxList<GeneralSearchedModel> searchedMovieList = <GeneralSearchedModel>[].obs;

  Future<bool> searchMovieTv() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(
        ApiConstant.generelMovieSearch(searchTextEditingController.value.text));

    if (response.statusCode == 200) {
      RxList<MovieResult> rawData = RxList<MovieResult>.from(
          response.body["results"].map((x) => MovieResult.fromJson(x)));

      var initial = rawData
          .map((element) => GeneralSearchedModel(
              genre: "",
              image: "$imageBaseUrl${element.backdropPath}",
              rating: "Rating ${element.voteAverage}",
              title: element.title!))
          .toList();

      searchedResult.addAll(initial);

      searchedMovieList.addAll(initial);

      // searchIs.value = true;
      searchIs.refresh();

      return true;
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);

      return false;
    }
  }

  //====================================Music Search===============================

  RxList<GeneralSearchedModel> searchedMusicList = <GeneralSearchedModel>[].obs;

  Future<bool> searchMusic() async {
    var response = await ApiClient.getData(
      ApiConstant.generelMusicSearch(searchTextEditingController.value.text),
      showbaseUrl: false,
    );

    if (response.statusCode == 200) {
      RxList<Track> rawData = RxList<Track>.from(response.body["results"]
              ["trackmatches"]["track"]
          .map((x) => Track.fromJson(x)));

      var initial = rawData
          .map((element) => GeneralSearchedModel(
              genre: "",
              image: "${element.image![2].text}",
              rating: "listeners ${element.listeners}",
              title: element.name!))
          .toList();

      searchedResult.addAll(initial);
      searchedMusicList.addAll(initial);

      return true;
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);

      return false;
    }
  }

//=====================================Combine Search===============================

  conbineSearch() async {
    bool isMovieTvSearch = await searchMovieTv();

    bool isMusicSearch = await searchMusic();

    if (isMusicSearch && isMovieTvSearch) {
      setRxRequestStatus(Status.completed);

      searchIs.value = true;
      refresh();
    }
  }
}

class GeneralSearchedModel {
  String image;

  String title;
  String genre;
  String rating;

  GeneralSearchedModel(
      {required this.genre,
      required this.image,
      required this.rating,
      required this.title});
}
