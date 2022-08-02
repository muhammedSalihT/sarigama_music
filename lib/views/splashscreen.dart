import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarigama_music1/controllers/home_page_controller.dart';
import 'package:sarigama_music1/controllers/favorite_controller.dart';
import 'package:sarigama_music1/controllers/musicplayer_controller.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());
  final HomePageController homePageController = Get.put(HomePageController());
  final DbFavController dbFavController = Get.put(DbFavController());
  final MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage(
                "assets/images/istockphoto-939443944-612x612.jpg"),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.1, sigmaY: 1.1),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 4, 4).withOpacity(0.6)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: SizedBox(
                height: 300.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/image-removebg-preview.png",
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        AnimatedTextKit(
                          pause: const Duration(milliseconds: 0),
                          animatedTexts: [
                            RotateAnimatedText("sarigama",
                                textStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    // fontFamily: "GrapeNuts",
                                    fontSize:
                                        MediaQuery.of(context).size.width * .12,
                                    decoration: TextDecoration.none,
                                    color: const Color.fromARGB(
                                        255, 244, 240, 240))),
                            RotateAnimatedText(
                              " music",
                              textStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                // fontFamily: "GrapeNuts",
                                fontSize:
                                    MediaQuery.of(context).size.width * .12,
                                decoration: TextDecoration.none,
                                color: const Color.fromARGB(255, 239, 235, 235),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Proudly Made In Bro",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "GrapeNuts")),
                        WidgetSpan(
                          child: Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 120, 14, 4),
                          ),
                        ),
                        TextSpan(
                            text: "Camp",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "GrapeNuts")),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
