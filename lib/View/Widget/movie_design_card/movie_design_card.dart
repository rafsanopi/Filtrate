import 'package:filtrate/Helper/network_image.dart';
import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MovieDesignCard extends StatelessWidget {
  final String image;
  final String title;
  final String ratting;
  final String genre;

  final bool showRating;

  final bool showImage;

  const MovieDesignCard(
      {super.key,
      required this.image,
      required this.title,
      required this.ratting,
      required this.genre,
      this.showImage = true,
      this.showRating = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(right: 8.w),
      height: 244.h,
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
      ),

      ///<============================Bottom Card==========================>

      child: Column(
        children: [
          //===========================Image======================

          if (showImage)
            CustomNetworkImage(
              imageUrl: image,
              height: 170.h,
              width: 150.w,
            ),

          if (showImage == false)
            Container(
              color: Colors.red,
              height: 170.h,
              width: 150.w,
            ),
          Container(
            height: 66.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                    3.r,
                  ),
                  bottomLeft: Radius.circular(3.r)),
              color: AppColors.purple_50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///<===========================Movie Name===========================>

                CustomText(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  bottom: 4.h,
                  text: title,
                  color: AppColors.black_500,
                  fontSize: 10.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///<===========================Movie Type===========================>

                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        right: 4.w,
                        fontSize: 8.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.purple_500,
                        text: genre,
                      ),
                    ),

                    ///<========================StarIcon================================>
                    if (showRating)
                      SvgPicture.asset(
                        AppIcons.starIcon,
                        colorFilter: const ColorFilter.mode(
                          AppColors.yellow_500,
                          BlendMode.srcIn,
                        ),
                        height: 8.h,
                        width: 8.w,
                      ),

                    ///<==========================AllRatting==========================>
                    CustomText(
                      left: 8.w,
                      text: ratting,
                      color: AppColors.black_500,
                      fontWeight: FontWeight.w400,
                      fontSize: 8.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
