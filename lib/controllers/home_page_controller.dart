import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/views/home_page.dart';
import '../views/favourite_screen.dart';
import '../views/home_screen.dart';
import '../views/music_player.dart';
import '../views/playlist-screen.dart';
import '../views/user_screen.dart';
import '../widget/ex_music.dart';

class HomePageController extends GetxController {
  int page = 0;
  int currindex = 0;

  HomePageController() {
    MyHomeScreen.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          currindex = index;
          update();
        }
      },
    );
  }

  void bottomNav(index) {
    page = index;
    update();
  }

  Widget bodyFunction() {
    switch (page) {
      case 0:
        return MyHomeScreen();

      case 1:
        return MyFavouriteScreen();

      case 2:
        if (MyHomeScreen.playlist.isEmpty) {
          return const ExMusic();
        } else {
          return MyMusic();
        }
      case 3:
        return const MyPlayListScreen();

      default:
        return const MyScreen();
    }
  }

  imageButton() {
    print('hi$allsong${MyHomeScreen.playlist}');
    if (MyHomeScreen.playlist.isNotEmpty) {
      return GetBuilder<HomePageController>(
        builder: (controller) =>  CircleAvatar(
          backgroundColor: const Color.fromARGB(158, 187, 166, 166),
          radius: 27.0,
          child: QueryArtworkWidget(
            id: allsong[currindex].id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget:
                Image.asset('assets/images/image-removebg-preview.png'),
            artworkBorder: BorderRadius.circular(30),
          ),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: const Color.fromARGB(158, 187, 166, 166),
        radius: 27.0,
        child: Image.asset('assets/images/image-removebg-preview.png'),
      );
    }
  }
}
