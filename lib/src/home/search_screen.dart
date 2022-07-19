

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/src/musicplayer/music_player.dart';
import 'package:sarigama_music1/functions/song_list.dart';
import 'package:sarigama_music1/src/home/home_page.dart';
import 'package:sarigama_music1/src/home/home_screen.dart';

import '../../widget/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

  final searchController = TextEditingController();

  int tempIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 47, 71, 45),
        title: SizedBox(
          width: 1200.0,
          height: 40,
          child: TextField(
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                temp.value.addAll(MyHomeScreen.playlist);
                temp.notifyListeners();
              } else {
                temp.value.clear();
                for (SongModel i in MyHomeScreen.playlist) {
                  if (i.title.toLowerCase().contains(
                            value.toLowerCase(),
                          ) ||
                      (i.artist!.toLowerCase().contains(
                            value.toLowerCase(),
                          ))) {
                    temp.value.add(i);
                  }
                  temp.notifyListeners();
                }
              }
            },
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: searchController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(55, 255, 255, 255),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Search songs',
              hintStyle: TextStyle(
                height: 0.5,
                color: Color.fromARGB(213, 255, 255, 255),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: backgroundgrd),
        ),
        child: ValueListenableBuilder(
          valueListenable: temp,
          builder:
              (BuildContext ctx, List<SongModel> searchdata, Widget? child) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: searchdata.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: GridTile(
                          child: QueryArtworkWidget(
                            id: searchdata[index].id,
                            type: ArtworkType.AUDIO,
                            artworkWidth: double.infinity,
                            artworkHeight: double.infinity,
                            nullArtworkWidget: Image.asset(
                                'assets/images/image-removebg-preview.png'),
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
                              ),
                              GestureDetector(
                                  onTap: () {
                                    allsong = searchdata;
                                    // MyMusic.audioPlayer.play();
                                    if (!MyHomeScreen.audioPlayer.playing ||
                                        tempIndex != index) {
                                      MyHomeScreen.audioPlayer.setAudioSource(
                                          createSongList(searchdata),
                                          initialIndex: index);
                                      MyHomeScreen.audioPlayer.play();
                                      tempIndex = index;
                                      MyMusic();
                                      Navigator.of(context).pop();
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
                      SizedBox(height: 15, child: Text(searchdata[index].title))
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
