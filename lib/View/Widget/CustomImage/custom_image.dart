import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
enum ImageType {
  png,
  svg,
}

class CustomImage extends StatefulWidget {
  final String imageSrc;
  final Color? imageColor;
  final double? height;
  final double? width;
  final ImageType imageType;
  final BoxFit fit;
  final double top;
  final double left;
  final double right;
  final double bottom;

  const CustomImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.width,
    this.imageType = ImageType.svg,
    this.fit = BoxFit.contain,
    super.key,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    if (widget.imageType == ImageType.svg) {
      imageWidget = SvgPicture.asset(
        widget.imageSrc,
        fit: widget.fit,
         colorFilter: const ColorFilter.mode(AppColors.purple_500, BlendMode.srcIn),
        height: 24.h,
        width: 24.w,
      );
    }

    if (widget.imageType == ImageType.png) {
      imageWidget = Image.asset(
        fit: widget.fit,
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
      );
    }

    return Container(
        margin: EdgeInsets.only(
            top: widget.top,
            bottom: widget.bottom,
            left: widget.left,
            right: widget.right),
        height: widget.height,
        width: widget.width,
        child: imageWidget);
  }
}
