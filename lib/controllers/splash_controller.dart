import 'dart:async';
import 'package:get/get.dart';
import 'package:sarigama_music1/views/home_page.dart';
import 'package:sarigama_music1/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {

  SplashController(){
    gotoLogin();
  }
  gotoLogin() async {
    Timer(const Duration(seconds: 4), (() {
      checkScreen();
    }));
  }

  void checkScreen() async {
    final data = await SharedPreferences.getInstance();
    final value = data.getBool(sharedCheck) ?? false;
    if (value == false) {
      Get.offAll( LoginPage());
    } else {
      Get.offAll(HomePage());
    }
  }
}
