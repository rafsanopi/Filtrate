import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Helper/network_image.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/View/Widget/custom_loader/loader.dart';
import 'package:filtrate/controller/admob_controller.dart';
import 'package:filtrate/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  HomeController homeController = Get.find<HomeController>();

  AdMobController adMobController = Get.find<AdMobController>();

  //dynamic data;

  APIStatus? serial;

  getTheData() {
    serial = Get.arguments[1];

    // data = Get.arguments[0];
  }

  @override
  void initState() {
    super.initState();
    getTheData();

    // adMobController.loadMultipleBannerAds();
    // super.initState();
  }

  // @override
  // void dispose() {
  //   for (var bannerAdd in adMobController.bannerAds) {
  //     bannerAdd.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64.h,
        title: CustomText(
          text: serial == APIStatus.movie
              ? AppString.movies
              : serial == APIStatus.tvSeries
                  ? AppString.tVSeries
                  : AppString.music,
          fontSize: 20,
          color: AppColors.black_500,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            //<<<<<<<<<<<========================Top Section [Filter]=============>>>>>>>>>>>>>>>>>
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///<=====================Filter Text================================>

                CustomText(
                  top: 24.h,
                  fontWeight: FontWeight.w400,
                  text: "Filter",
                  fontSize: 20,
                  color: AppColors.purple_500,
                ),

                ///<=====================Filtrate Icon================================>
                GestureDetector(
                    onTap: () {
                      if (serial == APIStatus.movie) {
                        Get.toNamed(AppRoute.searchByCetegaryScreen,
                            arguments: [
                              homeController.movieGerne,
                              APIStatus.movie
                            ]);
                      } else if (serial == APIStatus.tvSeries) {
                        Get.toNamed(AppRoute.searchByCetegaryScreen,
                            arguments: [
                              homeController.tvSeriesGerne,
                              APIStatus.tvSeries
                            ]);
                      } else {
                        Get.toNamed(AppRoute.searchByCetegaryScreen,
                            arguments: [
                              homeController.musicGenreList,
                              APIStatus.music
                            ]);
                      }
                    },
                    child: SvgPicture.asset(
                      AppIcons.filterIocn,
                      colorFilter: const ColorFilter.mode(
                          AppColors.black_500, BlendMode.srcIn),
                      height: 24.h,
                      width: 24.w,
                    )),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),

            //<<<<<<<<<<<========================Actual Content=============>>>>>>>>>>>>>>>>>

            Obx(() {
              switch (homeController.rxRequestStatus.value) {
                case Status.loading:
                  return const CustomLoader();
                case Status.internetError:
                  return const CustomLoader();
                case Status.error:
                  return const CustomLoader();

                case Status.completed:
                  if (serial == APIStatus.tvSeries &&
                      homeController.tvSeriesList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: CustomText(
                          text: AppString.noResultsFound,
                        ),
                      ),
                    );
                  }

                  if (serial == APIStatus.movie &&
                      homeController.movieList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: CustomText(
                          text: AppString.noResultsFound,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: serial == APIStatus.movie
                          ? homeController.movieScrollController
                          : serial == APIStatus.tvSeries
                              ? homeController.tvSeriesScrollController
                              : homeController.musicScrollController,
                      itemCount: serial == APIStatus.movie
                          ? homeController.movieList.length
                          : serial == APIStatus.tvSeries
                              ? homeController.tvSeriesList.length
                              : homeController.musicList.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index % 6 == 5) {
                          // Show ad
                          int adIndex = index ~/
                              6; // Calculate the index of the banner ad
                          BannerAd? bannerAdd =
                              adIndex < adMobController.bannerAds.length
                                  ? adMobController.bannerAds[adIndex]
                                  : null;
                          return SizedBox(
                            height: 100,
                            child: bannerAdd != null
                                ? AdWidget(ad: bannerAdd)
                                : const SizedBox(),
                          );
                        } else if (homeController.isLoadMoreRunning.value ==
                            false) {
                          dynamic movie;
                          dynamic tvSeries;
                          dynamic music;

                          if (serial == APIStatus.movie) {
                            movie = homeController.movieList[index];
                          } else if (serial == APIStatus.tvSeries) {
                            tvSeries = homeController.tvSeriesList[index];
                          } else {
                            music = homeController.musicList[index];
                          }
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.purple_50),
                            child: Row(children: [
                              ///<==================================Image Card=================================>

                              CustomNetworkImage(
                                imageUrl: serial == APIStatus.movie
                                    ? "${homeController.imageBaseUrl}${movie.posterPath}"
                                    : serial == APIStatus.tvSeries
                                        ? "${homeController.imageBaseUrl}${tvSeries.posterPath}"
                                        : "${music.image![2].text}",
                                height: 92.h,
                                width: 66.w,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),

                              ///<==============================Movie Name======================================>
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.left,
                                      bottom: 4.h,
                                      maxLines: 2,
                                      text: serial == APIStatus.movie
                                          ? movie.title!
                                          : serial == APIStatus.tvSeries
                                              ? tvSeries.name!
                                              : music.name,
                                      color: AppColors.purple_500,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ///<===========================Movie Type===========================>
                                        Expanded(
                                          child: CustomText(
                                            maxLines: 3,
                                            textAlign: TextAlign.left,
                                            right: 4.w,
                                            fontSize: 12.h,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.purple_500,
                                            text: serial == APIStatus.music
                                                ? ""
                                                : homeController.getGenreNames(
                                                    genreIds: serial ==
                                                            APIStatus.movie
                                                        ? movie.genreIds
                                                        : tvSeries.genreIds,
                                                    gerne: serial ==
                                                            APIStatus.movie
                                                        ? homeController
                                                            .movieGerne
                                                        : homeController
                                                            .tvSeriesGerne),
                                          ),
                                        ),

                                        ///<========================StarIcon================================>

                                        if (serial != APIStatus.music)
                                          SvgPicture.asset(
                                            AppIcons.starIcon,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.yellow_500,
                                              BlendMode.srcIn,
                                            ),
                                            height: 12.h,
                                            width: 12.w,
                                          ),

                                        ///<==========================AllRatting==========================>
                                        if (serial != APIStatus.music)
                                          CustomText(
                                            left: 8.w,
                                            text: serial == APIStatus.movie
                                                ? movie.voteAverage!
                                                    .toStringAsFixed(1)
                                                : tvSeries.voteAverage!
                                                    .toStringAsFixed(1),
                                            color: AppColors.black_500,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.w,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        } else {
                          return const CustomLoader();
                        }
                      },
                    ),
                  );
              }
            })
          ],
        ),
      ),
    );
  }
}
