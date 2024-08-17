import 'package:filtrate/Utils/AppColors/app_colors.dart';
import 'package:filtrate/Utils/AppString/app_string.dart';
import 'package:filtrate/View/Widget/BottomNavBar/bottom.dart';
import 'package:filtrate/View/Widget/CustomText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      appBar: AppBar(
        toolbarHeight: 64.h,
        title: const CustomText(
          color: AppColors.black_500,
          text: AppString.termsAndCondition,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: HtmlWidget(
          '''
    <p>By downloading and using the "Filtrate" mobile application ("App"), you agree to be bound by the following terms and conditions:</p>
    <h2>1. Acceptance of Terms</h2>
    <p>By downloading, installing, or using the App, you accept and agree to be bound by these Terms and Conditions. If you do not agree with these Terms and Conditions, you may not use the App.</p>
    <h2>2. Description of Service</h2>
    <p>The Filtrate App is designed to help users discover lists of TV shows, movies, and songs that match specific categories chosen by the user.</p>
    <h2>3. User Conduct</h2>
    <p>You agree not to use the App for any unlawful purpose or in any way that could damage, disable, overburden, or impair the App. You also agree not to use the App to collect any personally identifiable information of other users.</p>
    <h2>4. Content</h2>
    <p>The content provided through the App, including lists of TV shows, movies, and songs, is for informational purposes only. Filtrate does not endorse or guarantee the accuracy, completeness, or usefulness of any content provided through the App.</p>
    <h2>5. Intellectual Property</h2>
    <p>All intellectual property rights in the App and its content, including but not limited to copyrights, trademarks, and trade secrets, are owned by Filtrate or its licensors.</p>
    <h2>6. Privacy</h2>
    <p>Filtrate respects the privacy of its users. Please review our Privacy Policy to understand how we collect, use, and disclose information collected from users of the App.</p>
    <h2>7. Third-Party Links</h2>
    <p>The App may contain links to third-party websites or services that are not owned or controlled by Filtrate. Filtrate has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third-party websites or services.</p>
    <h2>8. Disclaimer of Warranties</h2>
    <p>The App is provided on an "as is" and "as available" basis, without warranties of any kind, either express or implied. Filtrate makes no warranty that the App will be uninterrupted, secure, or error-free.</p>
    <h2>9. Limitation of Liability</h2>
    <p>Filtrate shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the App, including but not limited to loss of profits, data, or goodwill.</p>
    <h2>10. Indemnification</h2>
    <p>You agree to indemnify and hold harmless Filtrate, its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, or expenses, including reasonable attorneys' fees and costs, arising out of or in any way connected with your use of the App or violation of these Terms and Conditions.</p>
    <h2>11. Changes to Terms and Conditions</h2>
    <p>Filtrate reserves the right to modify or replace these Terms and Conditions at any time. Your continued use of the App after any such changes constitutes your acceptance of the new Terms and Conditions.</p>
    <h2>12. Governing Law</h2>
    <p>These Terms and Conditions shall be governed by and construed in accordance with the laws of USA, without regard to its conflict of law provisions.</p>
    <h2>13. Contact Us</h2>
    <p>If you have any questions about these Terms and Conditions, please contact us at lilypringe34@gmail.com.</p>
    <p>By using the Filtrate App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.</p>
  ''',
        ),
      ),
    );
  }
}
