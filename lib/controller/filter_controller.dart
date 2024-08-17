import 'package:filtrate/Model/movie_model.dart';
import 'package:filtrate/Model/music_model.dart';
import 'package:filtrate/Model/tv_series_model.dart';
import 'package:filtrate/Service/api_check.dart';
import 'package:filtrate/Service/api_service.dart';
import 'package:filtrate/Service/api_url.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController with GetxServiceMixin {
  // final rxRequestStatus = Status.loading.obs;
  // void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  HomeController homeController = Get.find<HomeController>();
  var isLoadMoreRunning = false.obs;
  var totalPage = 0;
  var currentPage = 0;


  ///<================================This is for  filtering part======================================>

  List<String> gener = [
    "Any",
    "Action",
    "Horror",
    "Histori",
    "Sci-Fi",
    "Sport",
    "War",
    "Fantasy",
    "Fantasy",
    "Thriller",
    "Documentary",
    "Crime",
    "Comedy",
    "Biography",
    "Adventure",
  ];

  List<bool> isCheckedList = List<bool>.filled(16, false);

  bool movieExpened = false;
  bool tvExpened = false;
  bool musicExpened = false;

  int current = 0;
  bool isCheaked = false;

  ///<============================Search By Cetegary Part=================================>

  List<String> searchGener = [
    "Any",
    "Action",
    "Horror",
    "Histori",
    "Sci-Fi",
    "Sport",
    "War",
    "Fantasy",
    "Fantasy",
    "Thriller",
    "Documentary",
    "Crime",
    "Comedy",
    "Biography",
    "Adventure",
  ];

//==================================Clear Check Box=========================

//=============Clear Movie Check List===========

  clearMovieCheckBox() {
    homeController.movieCheckedList =
        List<bool>.filled(homeController.movieGerne.length, false);

    homeController.selectedMovieGenre.clear();
    debugPrint(
        "selected Movie Genre===============>>>>>>>>>>>>>>>${homeController.selectedMovieGenre}");
    homeController.update();
  }

  //=============Clear Tv  Check List===========

  clearTvSeriesCheckBox() {
    homeController.tvSeriesCheckedList =
        List<bool>.filled(homeController.tvSeriesGerne.length, false);

    homeController.selectedtvSeriesGenre.clear();
    debugPrint(
        "selected Tv Series Genre===============>>>>>>>>>>>>>>>${homeController.selectedMovieGenre}");
  }
//==============================Filter Movie List==============================

  filterMovie() async {
    homeController.setRxRequestStatus(Status.loading);
    homeController.movieList.value = [];

    String genresString = homeController.selectedMovieGenre.join(',');

    var response =
        await ApiClient.getData(ApiConstant.searchByGenMovie(genresString));
    if (response.statusCode == 200) {
      homeController.movieList.value = RxList<MovieResult>.from(
          response.body["results"].map((x) => MovieResult.fromJson(x)));

      homeController.movieList.refresh();

      if (homeController.movieList.isNotEmpty) {
        currentPage = response.body['page'];
        totalPage = response.body['total_pages'];
      }
      homeController.setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        homeController.setRxRequestStatus(Status.internetError);
      } else {
        homeController.setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

//==============================Load More Filter Movie List==============================

  loadMorefilterMovies() async {
    String genresString = homeController.selectedMovieGenre.join(',');
    debugPrint("============================>>>>>>>>>load more MovieResult");
    if (homeController.rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      homeController.moviePage.value += 1;

      var response = await ApiClient.getData(ApiConstant.searchByGenMovie(
          "$genresString&page=${homeController.moviePage}"));

      currentPage = response.body['page'];
      totalPage = response.body['total_pages'];

      if (response.statusCode == 200) {
        var getList = RxList<MovieResult>.from(
            response.body["results"].map((x) => MovieResult.fromJson(x)));

        homeController.movieList.addAll(getList);

        debugPrint(
            "Movie Length===============>>>>>>>>>>>>${homeController.movieList.length}");
        homeController.movieList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

//==============================Filter Tv Series List==============================

  filterTvSeries() async {
    homeController.setRxRequestStatus(Status.loading);
    homeController.tvSeriesList.value = [];

    String genresString = homeController.selectedtvSeriesGenre.join(',');

    var response =
        await ApiClient.getData(ApiConstant.searchTvByGen(genresString));
    if (response.statusCode == 200) {
      homeController.tvSeriesList.value = RxList<TvSeriesResult>.from(
          response.body["results"].map((x) => TvSeriesResult.fromJson(x)));

      homeController.tvSeriesList.refresh();

      if (homeController.tvSeriesList.isNotEmpty) {
        currentPage = response.body['page'];
        totalPage = response.body['total_pages'];
      }
      homeController.setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        homeController.setRxRequestStatus(Status.internetError);
      } else {
        homeController.setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  loadMoreFilterTvSeries() async {
    String genresString = homeController.selectedtvSeriesGenre.join(',');
    debugPrint(
        "============================>>>>>>>>>load more load More Filter Tv Series");
    if (homeController.rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      homeController.tvSeriesPage.value += 1;

      var response = await ApiClient.getData(ApiConstant.searchByGenMovie(
          "$genresString&page=${homeController.tvSeriesPage}"));

      currentPage = response.body['page'];
      totalPage = response.body['total_pages'];

      if (response.statusCode == 200) {
        var getList = RxList<TvSeriesResult>.from(
            response.body["results"].map((x) => TvSeriesResult.fromJson(x)));

        homeController.tvSeriesList.addAll(getList);

        debugPrint(
            "Movie Length===============>>>>>>>>>>>>${homeController.tvSeriesList.length}");
        homeController.tvSeriesList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

//=======================================Filter Music=========================================

  filterMusic() async {
    homeController.setRxRequestStatus(Status.loading);
    homeController.musicList.value = [];

    String genresString = homeController.selectedMusicGenre.join(',');

    var response = await ApiClient.getData(
        ApiConstant.musicGenreFilter(genresString),
        showbaseUrl: false);

    if (response.statusCode == 200) {
      homeController.musicList.value = RxList<Track>.from(
          response.body["tracks"]["track"].map((x) => Track.fromJson(x)));
      homeController.setRxRequestStatus(Status.completed);
      homeController.musicList.refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        homeController.setRxRequestStatus(Status.internetError);
      } else {
        homeController.setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }
}
