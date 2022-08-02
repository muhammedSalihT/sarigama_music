import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/controllers/favorite_controller.dart';
import 'package:sarigama_music1/controllers/home_page_controller.dart';
import 'package:sarigama_music1/controllers/home_screen_controller.dart';
import 'package:sarigama_music1/functions/favlist_button.dart';
import 'package:sarigama_music1/views/music_player.dart';
import 'package:sarigama_music1/views/search_screen.dart';
import 'package:sarigama_music1/functions/song_list.dart';
import 'package:sarigama_music1/views/home_page.dart';
import 'add_playlist.dart';

class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({Key? key}) : super(key: key);

  final MyHomeScreenController myHomeScreenController =
      Get.put(MyHomeScreenController());
  final DbFavController dbFavController = Get.find();
  final HomePageController homePageController = Get.find();

  static List<SongModel> playlist = [];

  static AudioPlayer audioPlayer = AudioPlayer();

  int tempIndex = 0;

  pauseSong() {
    MyHomeScreen.audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    print("object");
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                const Text(
                  'Sarigama',
                  style: TextStyle(
                      color: Color.fromARGB(209, 78, 11, 11), fontSize: 35.0),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 13.0),
                    child: Text(
                      'music',
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                          fontSize: 15.0),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .24,
                ),
                IconButton(
                  icon: const Icon(Icons.search_outlined),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                )
              ],
            ),
          ),
          body: GetBuilder<MyHomeScreenController>(
              builder: (controller) => FutureBuilder<List<SongModel>>(
                  future: myHomeScreenController.audioQuery.querySongs(
                    sortType: SongSortType.DATE_ADDED,
                    orderType: OrderType.DESC_OR_GREATER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                  builder: (context, item) {
                    if (item.data == null) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                        semanticsLabel: "Fetching",
                      ));
                    }
                    if (item.data!.isEmpty) {
                      return const Center(child: Text("Please Add Songs"));
                    }

                    print(MyHomeScreen.playlist);

                    MyHomeScreen.playlist = item.data!;
                    print(MyHomeScreen.playlist);
                    allsong = MyHomeScreen.playlist;
                    print(allsong);

                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        itemCount: MyHomeScreen.playlist.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Expanded(
                                child: GridTile(
                                  child: QueryArtworkWidget(
                                    id: MyHomeScreen.playlist[index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkWidth: double.infinity,
                                    artworkHeight: double.infinity,
                                    nullArtworkWidget: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/playstore.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    artworkBorder: BorderRadius.circular(30),
                                  ),
                                  header: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0)),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromARGB(241, 0, 0, 0),
                                                Color(0x88000000),
                                                Colors.transparent
                                              ]),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Buttons(
                                                id: MyHomeScreen
                                                    .playlist[index].id),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.playlist_add,
                                                  color: Color.fromARGB(
                                                      131, 255, 255, 255),
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  final id = MyHomeScreen
                                                      .playlist[index].id;
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddPlaylist(
                                                              list: MyHomeScreen
                                                                      .playlist[
                                                                  index],
                                                              id: id,
                                                            )),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            allsong = MyHomeScreen.playlist;
                                            // MyMusic.audioPlayer.play();
                                            if (!MyHomeScreen
                                                    .audioPlayer.playing ||
                                                tempIndex != index) {
                                              MyHomeScreen.audioPlayer
                                                  .setAudioSource(
                                                      createSongList(
                                                          MyHomeScreen
                                                              .playlist),
                                                      initialIndex: index);
                                              MyHomeScreen.audioPlayer.play();
                                              // currindex = index;
                                              tempIndex = index;
                                              MyMusic();
                                            } else {
                                              MyHomeScreen.audioPlayer.pause();
                                              // index = tempIndex;
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            height: 110.0,
                                          ))
                                    ],
                                  ),
                                  footer: Container(
                                    height: 35.0,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0)),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color.fromARGB(241, 0, 0, 0),
                                            Color(0x88000000),
                                            Colors.transparent
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 15,
                                  child:
                                      Text(MyHomeScreen.playlist[index].title))
                            ],
                          );
                        });
                  }))),
    );
  }
}
