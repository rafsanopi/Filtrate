import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/View/Widget/movie_design_card/movie_design_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeDesignCardShimmer extends StatelessWidget {
  const HomeDesignCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            5,
            (index) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: AppColors.purple_100,
                  child: const MovieDesignCard(
                      showImage: false,
                      image: "",
                      title: "title",
                      ratting: "ratting",
                      genre: "genre"),
                )),
      ),
    );
  }
}
