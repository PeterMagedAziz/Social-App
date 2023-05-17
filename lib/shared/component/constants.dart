import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:share/shared/network/local/cache_helper.dart';

import '../../modules/login/social_login_screen.dart';
import '../size_config.dart';
import 'component.dart';
GetIt di = GetIt.I..allowReassignment = true;
dynamic token = '';
dynamic uId = '';
const TextStyle textStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
const kPrimaryColor = Colors.deepOrange;
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);


// String? token;
void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
        (value) {
      navigateReplacementTo(
        context,
        const SocialLoginScreen(),
      );
    },
  );
}


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


