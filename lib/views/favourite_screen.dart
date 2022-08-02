import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/controllers/home_page_controller.dart';
import 'package:sarigama_music1/controllers/home_screen_controller.dart';
import 'package:sarigama_music1/functions/favlist_button.dart';
import 'package:sarigama_music1/functions/song_list.dart';
import 'package:sarigama_music1/views/home_page.dart';

import '../controllers/favorite_controller.dart';
import 'home_screen.dart';

class MyFavouriteScreen extends StatelessWidget {
   MyFavouriteScreen({Key? key}) : super(key: key);

  DateTime timeBackPressed = DateTime.now();
  final controller = ScrollController();

  final DbFavController dbFavController = Get.find();
  final HomePageController homePageController = Get.find();
  final MyHomeScreenController myHomeScreenController = Get.find();
  var tempIndex = 0;
 

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                'Sarigama',
                style: TextStyle(
                    color: Color.fromARGB(209, 78, 11, 11), fontSize: 35.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 13.0),
                child: Text(
                  'Favorite',
                  style: TextStyle(
                      color: Color.fromARGB(255, 250, 250, 250),
                      fontSize: 15.0),
                ),
              )
            ],
          ),
        ),
        body:GetBuilder<DbFavController>(
          builder: (controller) => 
          GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: dbFavController.favourites.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: GestureDetector(
                        onTap: () {
                          List<SongModel> newfav = [];
                          // allsong = DbFav.favloop;
                          if (!MyHomeScreen.audioPlayer.playing ||
                              tempIndex != index) {
                            MyHomeScreen.audioPlayer.setAudioSource(
                                createSongList(dbFavController.favloop),
                                initialIndex: index);
                            newfav.addAll(dbFavController.favloop);
                            allsong = newfav;
                            tempIndex = index;
                            MyHomeScreen.audioPlayer.play();
                          } else {
                            MyHomeScreen.audioPlayer.pause();
                          }
                        },
                        child: QueryArtworkWidget(
                          id: MyHomeScreen.playlist[dbFavController.favourites[index]].id,
                          type: ArtworkType.AUDIO,
                          artworkWidth: double.infinity,
                          artworkHeight: double.infinity,
                          nullArtworkWidget: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/playstore.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          artworkBorder: BorderRadius.circular(30),
                        ),
                      ),
                      header: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(136, 236, 233, 233),
                                Color.fromARGB(94, 186, 182, 182),
                                Color.fromARGB(0, 126, 122, 122)
                              ]),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Buttons(
                              id: MyHomeScreen.playlist[dbFavController.favourites[index]].id,
                            );
        
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(15, 0, 0, 0),
                                  // title: const Text(
                                  //     'do you want to remove the song?'),
                                  content: const Text(
                                    'Do you want to remove the song?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          dbFavController.deletion(index);
                                          const snackBar = SnackBar(
                                              duration: Duration(seconds: 1),
                                              content: Text(
                                                  'Removed from favourites'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.of(ctx).pop();
                                          // setState(() {
                                          //   allsong = DbFav.favloop;
                                          // });
                                        },
                                        child: const Text('Yes'))
                                  ],
                                );
                              },
                            );
                          },
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.favorite,
                                color: Color.fromARGB(255, 145, 22, 22),
                              ),
                            ],
                          ),
                        ),
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
                                Color.fromARGB(190, 0, 0, 0),
                                Color.fromARGB(128, 0, 0, 0),
                                Color.fromARGB(10, 0, 0, 0)
                              ]),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              MyHomeScreen.playlist[dbFavController.favourites[index]].title,
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    );
                  }),
        )
      ),
    );
  }
}
