import 'package:filtrate/Core/AppRoutes/app_route.dart';
import 'package:filtrate/Utils/AppIcons/apo_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var bottomNavIndex = 0;
  List<String> routeScreen = [
    AppRoute.homePage,
    AppRoute.searchScreen,
    AppRoute.chatGptScreen,
    AppRoute.cetegaryScreen
  ];
  List<String> activeIcon = [
    AppIcons.homeActive,
    AppIcons.searchActive,
    AppIcons.selectedAI,
    AppIcons.categoryActive
  ];

  List<String> icon = [
    AppIcons.homeIocn,
    AppIcons.searchNav,
    AppIcons.unSelectedAI,
    AppIcons.categorySvg
  ];
  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      height: 90.h,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.45, 0.64),
          end: Alignment(0.77, -0.64),
          colors: [Color(0xFF7668A9), Color(0xFF2E2451)],
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icon.length,
            (index) {
              return IconButton(
                  onPressed: () {
                    setState(() {
                      bottomNavIndex = index;
                      Get.offNamed(routeScreen[bottomNavIndex]);
                    });
                  },
                  icon: SvgPicture.asset(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    index != bottomNavIndex ? icon[index] : activeIcon[index],
                  ));
            },
          )),
    );
  }
}
