import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64.h,
        title: const CustomText(
          color: AppColors.black_500,
          text: AppString.aboutUs,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: HtmlWidget(
          '''
 
    <p>Welcome to Filtrate, your go-to app for discovering TV shows, movies, and songs that perfectly match your interests and categories. Our mission is to help you find and enjoy entertainment content tailored to your preferences.</p>
    
    <h2>Our Service</h2>
    <p>Filtrate is designed to assist users in exploring curated lists of TV shows, movies, and songs based on specific categories you choose. Whether you are in the mood for a new thriller, an inspiring documentary, or the latest hits, Filtrate provides a personalized experience to enhance your entertainment journey.</p>
    
    <h2>Our Values</h2>
    <p>We prioritize providing a service that is user-friendly, informative, and engaging. Our goal is to make the discovery process enjoyable and effortless, ensuring that you have access to accurate and comprehensive lists of content that you will love.</p>
    
    <h2>Privacy and Security</h2>
    <p>At Filtrate, we respect the privacy of our users. We are committed to protecting your personal information and ensuring a safe and secure experience within our app. Please review our Privacy Policy to understand how we collect, use, and safeguard your information.</p>
    
    <h2>Our Team</h2>
    <p>Our dedicated team of developers, designers, and content curators work tirelessly to bring you a seamless and enriching experience. We are passionate about entertainment and technology, striving to innovate and improve our app continuously.</p>
    
    
  ''',
        ),
      ),
    );
  }
}
