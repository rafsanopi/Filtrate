import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppConst/app_const.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:filtrate/View/Widget/custom_loader/loader.dart';
import 'package:filtrate/View/Widget/movie_design_card/movie_design_card.dart';
import 'package:filtrate/View/Widget/shimmer_effects/shimmer_effects.dart';
import 'package:filtrate/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MovieSection extends StatelessWidget {
  MovieSection({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                ///<==============================Purple Dot================================>
                Container(
                  height: 8.h,
                  width: 8.w,
                  decoration: const BoxDecoration(
                      color: AppColors.purple_500, shape: BoxShape.circle),
                ),

                ///<==============================MovieText================================>

                CustomText(
                  text: AppString.movies,
                  color: AppColors.black_500,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  left: 4.w,
                ),
              ],
            ),

            ///<=================================See All Text==========================>
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.seeAllScreen, arguments: [
                  homeController.movieList,
                  APIStatus.movie,
                ]);
              },
              child: const CustomText(
                text: AppString.seeAll,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.purple_600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Obx(() {
          switch (homeController.rxRequestStatus.value) {
            case Status.loading:
              return const HomeDesignCardShimmer();
            case Status.internetError:
              return const CustomLoader();
            case Status.error:
              return const CustomLoader();

            case Status.completed:
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: homeController.movieList.isNotEmpty &&
                        homeController.movieList.length >= 5
                    ? Row(
                        children: List.generate(
                        5,
                        (index) {
                          var data = homeController.movieList[index];

                          ///<===========================Main  Card=================================>
                          return MovieDesignCard(
                              image:
                                  "${homeController.imageBaseUrl}${data.posterPath}",
                              title: data.title!,
                              ratting: data.voteAverage!.toStringAsFixed(1),
                              genre: homeController.getGenreNames(
                                  genreIds: data.genreIds,
                                  gerne: homeController.movieGerne));
                        },
                      ))
                    : const Center(
                        child: CustomText(
                          text: AppString.noResultsFound,
                        ),
                      ),
              );
          }
        }),
      ],
    );
  }
}
