import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarigama_music1/controllers/favorite_controller.dart';
import 'package:sarigama_music1/controllers/home_page_controller.dart';
import 'package:sarigama_music1/controllers/home_screen_controller.dart';
import 'package:sarigama_music1/controllers/musicplayer_controller.dart';
import 'package:sarigama_music1/functions/favlist_button.dart';
import 'package:sarigama_music1/views/add_playlist.dart';
import 'package:sarigama_music1/views/home_screen.dart';
import 'package:sarigama_music1/views/home_page.dart';

// ignore: must_be_immutable
class MyMusic extends StatelessWidget {
  MyMusic({Key? key}) : super(key: key);

  final HomePageController homePageController = Get.find();
  final MusicController musicController = Get.find();
  final DbFavController controller = Get.find();
  final MyHomeScreenController myHomeScreenController = Get.find();

  final Color _buttonColor2 = Colors.white;

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
        MyHomeScreen.audioPlayer.positionStream,
        MyHomeScreen.audioPlayer.durationStream,
        (position, duration) =>
            DurationState(position: position, total: duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    Get.height;
    print("objectss");
    DateTime timeBackPressed = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = 'Press back again to exit from app';
          Fluttertoast.showToast(
              msg: message,
              fontSize: 18,
              backgroundColor: const Color.fromARGB(167, 15, 14, 14));
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 209, 30, 30),
        body: GetBuilder<MusicController>(
          init: MusicController(),
          builder: (controller) => Column(
            children: [
              Expanded(
                child: GridTile(
                  child: musicController.imageButton(),
                  header: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 50,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(207, 78, 11, 11),
                            Color.fromARGB(161, 78, 11, 11),
                            Color.fromARGB(69, 78, 11, 11),
                            Colors.transparent
                          ]),
                    ),
                  ),
                  footer: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0x88000000),
                            Color.fromARGB(241, 0, 0, 0),
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<DbFavController>(
                          builder: (controller) => 
                           Buttons(id: allsong[musicController.currentIndex].id)),
                        IconButton(
                            iconSize: 40,
                            icon: const Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final id =
                                  allsong[musicController.currentIndex].id;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AddPlaylist(
                                          list: allsong[
                                              musicController.currentIndex],
                                          id: id,
                                        )),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    allsong[musicController.currentIndex].title,
                    style: const TextStyle(
                      fontSize: 29,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    allsong[musicController.currentIndex].artist.toString() ==
                            '<unknown>'
                        ? "unknown Artist"
                        : allsong[musicController.currentIndex]
                            .artist
                            .toString(),
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
                child: Column(
                  children: [
                    //slider bar container
                    StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return ProgressBar(
                          timeLabelLocation: TimeLabelLocation.sides,
                          progress: progress,
                          total: total,
                          barHeight: 3.0,
                          baseBarColor: Colors.white,
                          progressBarColor: Color.fromARGB(233, 78, 11, 11),
                          thumbColor: Color.fromARGB(255, 78, 11, 11),
                          timeLabelTextStyle: const TextStyle(
                            fontSize: 0,
                          ),
                          onSeek: (duration) {
                            MyHomeScreen.audioPlayer.seek(duration);
                          },
                        );
                      },
                    ),

                    //position /progress and total text
                    StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                progress.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                total.toString().split(".")[0],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _previousButton(),
                    _playButton(),
                    _nextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    MyHomeScreen.audioPlayer.seek(duration);
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            MyHomeScreen.audioPlayer.playing
                ? Icons.pause_circle
                : Icons.play_circle,
            color: _buttonColor2,
          ),
          iconSize: 75.0,
          onPressed: () {
            if (MyHomeScreen.audioPlayer.playing) {
              MyHomeScreen.audioPlayer.stop();
            } else {
              if (MyHomeScreen.audioPlayer.currentIndex != null) {
                MyHomeScreen.audioPlayer.play();
              }
            }
          },
        );
      },
    );
  }

  StreamBuilder<PlayerState> _previousButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Color.fromARGB(217, 255, 255, 255),
          ),
          iconSize: 80.0,
          onPressed: () {
            if (MyHomeScreen.audioPlayer.hasPrevious) {
              MyHomeScreen.audioPlayer.seekToPrevious();
            }
          },
        );
      },
    );
  }

  StreamBuilder<PlayerState> _nextButton() {
    return StreamBuilder<PlayerState>(
      builder: (context, snapshot) {
        return IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Color.fromARGB(217, 255, 255, 255),
          ),
          iconSize: 80,
          onPressed: () {
            if (MyHomeScreen.audioPlayer.hasNext) {
              MyHomeScreen.audioPlayer.seekToNext();
            }
          },
        );
      },
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
