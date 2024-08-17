import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Screens/HomPage/InnerWidget/movie_list.dart';
import 'package:filtrate/View/Screens/HomPage/InnerWidget/music.dart';
import 'package:filtrate/View/Screens/HomPage/InnerWidget/tv_series.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///<====================================Title============================================>
              ///

              CustomText(
                top: 20.h,
                text: AppString.filtrate,
                color: AppColors.purple_500,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
              SizedBox(
                height: 24.h,
              ),

              ///<=================================Movies Section============================>

              MovieSection(),

              SizedBox(
                height: 24.h,
              ),

              ///<=================================Tv series Section==========================>
              TvSeries(),

              SizedBox(
                height: 24.h,
              ),

              ///<=================================Music Section==========================>
              Music(),
            ],
          ),
        ),
      ),
    );
  }
}
