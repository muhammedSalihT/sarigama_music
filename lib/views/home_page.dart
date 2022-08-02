import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/controllers/home_page_controller.dart';
import 'package:sarigama_music1/controllers/home_screen_controller.dart';
import 'package:sarigama_music1/views/home_screen.dart';
import 'package:sarigama_music1/widget/colors.dart';

List<SongModel> allsong = MyHomeScreen.playlist;

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageController homePageController = Get.find();
  final MyHomeScreenController myHomeScreenController =
      Get.put(MyHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: backgroundgrd),
          ),
          child: GetBuilder<HomePageController>(builder: (controller) {
            return controller.bodyFunction();
          })),
      bottomNavigationBar: CurvedNavigationBar(
          color: const Color.fromARGB(214, 187, 166, 166),
          items: <Widget>[
            SizedBox(
              height: 50.0,
              child: Column(
                children: const [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Color.fromARGB(222, 5, 4, 4),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: Color.fromARGB(222, 5, 4, 4)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
              child: Column(
                children: const [
                  Icon(
                    Icons.favorite,
                    size: 30,
                    color: Color.fromARGB(222, 5, 4, 4),
                  ),
                  Text(
                    "Favorite",
                    style: TextStyle(color: Color.fromARGB(222, 5, 4, 4)),
                  )
                ],
              ),
            ),
            homePageController.imageButton(),
            SizedBox(
              height: 50.0,
              child: Column(
                children: const [
                  Icon(
                    Icons.playlist_play,
                    size: 30,
                    color: Color.fromARGB(222, 5, 4, 4),
                  ),
                  Text(
                    "Playlist",
                    style: TextStyle(color: Color.fromARGB(222, 5, 4, 4)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
              child: Column(
                children: const [
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Color.fromARGB(222, 5, 4, 4),
                  ),
                  Text(
                    "About",
                    style: TextStyle(color: Color.fromARGB(222, 5, 4, 4)),
                  )
                ],
              ),
            ),
          ],
          index: 0,
          height: 50.0,
          buttonBackgroundColor: const Color.fromARGB(209, 78, 11, 11),
          backgroundColor: const Color.fromARGB(214, 187, 166, 166),
          animationCurve: Curves.ease,
          animationDuration: const Duration(milliseconds: 1200),
          onTap: (index) {
            homePageController.bottomNav(index);
          }),
    );
  }

  
}
