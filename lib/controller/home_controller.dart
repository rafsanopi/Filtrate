import 'package:filtrate/Model/movie_genre_model.dart';
import 'package:filtrate/Model/music_genre_list.dart';
import 'package:filtrate/Model/music_model.dart';
import 'package:filtrate/Model/tv_series_model.dart';
import 'package:filtrate/Service/api_check.dart';
import 'package:filtrate/Service/api_service.dart';
import 'package:filtrate/Service/api_url.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Model/movie_model.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// "poster_sizes": [
// "w92",
// "w154",
// "w185",
// "w342",
// "w500",
// "w780",
// "original"
// ],

class HomeController extends GetxController with GetxServiceMixin {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  var isLoadMoreRunning = false.obs;

  var totalPage = 0;
  var currentPage = 0;

  final String imageBaseUrl = "https://image.tmdb.org/t/p/w154/";

  ///<<<<<<<<<<<<=============================MoVieList===============================>>>>>>>>>>>>

  RxList<MovieResult> movieList = <MovieResult>[].obs;
  RxList<Genre> movieGerne = <Genre>[].obs;
  List<bool> movieCheckedList = [];
  List<int> selectedMovieGenre = [];

  //============Get Movie List Genre==========

  Future<bool> getMovieGerneList() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiConstant.movieGenList);

    if (response.statusCode == 200) {
      movieGerne.value = RxList<Genre>.from(
          response.body["genres"].map((x) => Genre.fromJson(x)));

      movieCheckedList = List<bool>.filled(movieGerne.length, false);

      return getMovieList();
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

  //============Get Movie List==========

  Future<bool> getMovieList() async {
    var response = await ApiClient.getData(ApiConstant.getMovie);
    if (response.statusCode == 200) {
      movieList.value = RxList<MovieResult>.from(
          response.body["results"].map((x) => MovieResult.fromJson(x)));

      if (movieList.isNotEmpty) {
        currentPage = response.body['page'];
        totalPage = response.body['total_pages'];
      }
      // setRxRequestStatus(Status.completed);

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

//==============Movie List Pagination==========
  RxInt moviePage = 1.obs;
  ScrollController movieScrollController = ScrollController();

  Future<void> movieaddScrollListener() async {
    final FilterController searchFilterController =
        Get.find<FilterController>();
    if (movieScrollController.position.pixels ==
        movieScrollController.position.maxScrollExtent) {
      if (selectedMovieGenre.isNotEmpty) {
        searchFilterController.loadMorefilterMovies();
      } else {
        loadMoreMovies();
      }
    }
  }

  loadMoreMovies() async {
    debugPrint("============================>>>>>>>>>load more MovieResult");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      moviePage.value += 1;

      var response =
          await ApiClient.getData("${ApiConstant.getMovie}&page=$moviePage");

      currentPage = response.body['page'];
      totalPage = response.body['total_pages'];

      if (response.statusCode == 200) {
        var getList = RxList<MovieResult>.from(
            response.body["results"].map((x) => MovieResult.fromJson(x)));

        movieList.addAll(getList);

        debugPrint(
            "Movie Length===============>>>>>>>>>>>>${movieList.length}");
        movieList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

//<<<<<<<<<<<<<<=================================Tv Series===============================>>>>>>>>>>>>>>>

  RxList<Genre> tvSeriesGerne = <Genre>[].obs;
  RxList<TvSeriesResult> tvSeriesList = <TvSeriesResult>[].obs;

  List<bool> tvSeriesCheckedList = [];
  List<int> selectedtvSeriesGenre = [];

  //============Get Tv Series List Genre==========

  Future<bool> getTVSeriesGerneList() async {
    var response = await ApiClient.getData(ApiConstant.tvSeriesGenrList);

    if (response.statusCode == 200) {
      tvSeriesGerne.value = RxList<Genre>.from(
          response.body["genres"].map((x) => Genre.fromJson(x)));

      tvSeriesCheckedList = List<bool>.filled(tvSeriesGerne.length, false);

      return getTvSeriesList();
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

  //============Get Tv Series List==========

  Future<bool> getTvSeriesList() async {
    var response = await ApiClient.getData(ApiConstant.getTvSeries);
    if (response.statusCode == 200) {
      tvSeriesList.value = RxList<TvSeriesResult>.from(
          response.body["results"].map((x) => TvSeriesResult.fromJson(x)));

      if (tvSeriesList.isNotEmpty) {
        currentPage = response.body['page'];
        totalPage = response.body['total_pages'];
      }
      // setRxRequestStatus(Status.completed);

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

//==============Movie List Pagination==========
  RxInt tvSeriesPage = 1.obs;
  ScrollController tvSeriesScrollController = ScrollController();

  Future<void> tvSeriesAddScrollListener() async {
    if (tvSeriesScrollController.position.pixels ==
        tvSeriesScrollController.position.maxScrollExtent) {
      if (selectedtvSeriesGenre.isNotEmpty) {
        // searchFilterController.loadMoreFilterTvSeries();
      } else {
        loadMoreTvSeries();
      }
    }
  }

  loadMoreTvSeries() async {
    debugPrint("============================>>>>>>>>>load more TvSeriesResult");
    if (rxRequestStatus.value != Status.loading &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      tvSeriesPage.value += 1;

      var response = await ApiClient.getData(
          "${ApiConstant.getTvSeries}&page=$tvSeriesPage");

      currentPage = response.body['page'];
      totalPage = response.body['total_pages'];

      if (response.statusCode == 200) {
        var getList = RxList<TvSeriesResult>.from(
            response.body["results"].map((x) => TvSeriesResult.fromJson(x)));

        tvSeriesList.addAll(getList);

        debugPrint(
            "Movie Length===============>>>>>>>>>>>>${tvSeriesList.length}");
        tvSeriesList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

//<<<<<<<<<<<<<<=================================Music List===============================>>>>>>>>>>>>>>>

  RxList<Track> musicList = <Track>[].obs;
  RxList<Tag> musicGenreList = <Tag>[].obs;
  List<bool> musicGenreCheckedList = [];
  List<String> selectedMusicGenre = [];

  //==========Get music Genre List=============

  Future<bool> getMusicGenreList() async {
    var response =
        await ApiClient.getData(ApiConstant.musicGenreList, showbaseUrl: false);

    if (response.statusCode == 200) {
      musicGenreList.value = RxList<Tag>.from(
          response.body["toptags"]["tag"].map((x) => Tag.fromJson(x)));

      musicGenreCheckedList = List<bool>.filled(musicGenreList.length, false);

      debugPrint(
          "Music Genre List=======================>>>>>>>>>>>>>>${musicGenreList.length}");

      return getMusic();
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

  Future<bool> getMusic() async {
    var response =
        await ApiClient.getData(ApiConstant.musicList, showbaseUrl: false);

    if (response.statusCode == 200) {
      musicList.value = RxList<Track>.from(
          response.body["tracks"]["track"].map((x) => Track.fromJson(x)));

      // debugPrint("Body^^^^^^^^^^^^...........${response.body}");

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

  ScrollController musicScrollController = ScrollController();

//=========================== First time load Every API ============================

  homeScreenData() async {
    final movieLoaded = await getMovieGerneList();
    final tvSeriesLoaded = await getTVSeriesGerneList();

    final musicListLoaded = await getMusicGenreList();

    if (movieLoaded && tvSeriesLoaded && musicListLoaded) {
      setRxRequestStatus(Status.completed);
    }
  }

//=============================Convert GenreIDs to GenreName=============================

  String getGenreNames(
      {required List<int>? genreIds, required RxList<Genre> gerne}) {
    if (genreIds == null || genreIds.isEmpty) {
      return 'Unknown';
    }

    List<String> genreNames = [];
    for (int id in genreIds) {
      final genre = gerne.firstWhere(
        (genre) => genre.id == id,
      );
      genreNames.add(genre.name ?? 'Unknown'); // Handle null name
    }

    if (genreNames.isEmpty) {
      return 'Unknown';
    }

    return genreNames.join(', ');
  }

  @override
  void onInit() {
    movieScrollController.addListener(movieaddScrollListener);
    tvSeriesScrollController.addListener(tvSeriesAddScrollListener);

    homeScreenData();
    super.onInit();
  }
}
