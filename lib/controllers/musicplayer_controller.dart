import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/views/home_page.dart';
import 'package:sarigama_music1/views/home_screen.dart';

class MusicController extends GetxController {
  bool isPlaying = false;

  int currentIndex = 0;
  String currentTitle = '';

  playing() {
    isPlaying = !isPlaying;
    update();
  }

  @override
  void onInit() {
    MyHomeScreen.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
    super.onInit();
  }

  void _updateCurrentPlayingSongDetails(int index) {
    if (allsong.isNotEmpty) {
      currentTitle = allsong[index].title;
      currentIndex = index;
      update();
    }
  }

  imageButton() {
    if (MyHomeScreen.playlist.isNotEmpty) {
      return GetBuilder<MusicController>(
        builder: (controller) => QueryArtworkWidget(
          artworkQuality: FilterQuality.high,
          id: allsong[currentIndex].id,
          type: ArtworkType.AUDIO,
          artworkWidth: double.infinity,
          artworkHeight: Get.height * .5,
          artworkFit: BoxFit.fill,
          artworkBorder: const BorderRadius.only(
              bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          nullArtworkWidget: SizedBox(
            width: double.infinity,
            height: Get.height * .5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/images/playstore.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
          width: double.infinity,
          height: Get.height * .5,
          child: Image.asset('assets/images/image-removebg-preview.png'));
    }
    
  }
}
