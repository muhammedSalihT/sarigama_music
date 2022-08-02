import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/views/home_screen.dart';

import '../functions/playlist_button.dart';

// ignore: must_be_immutable
class Addsongs extends StatefulWidget {
  Addsongs({
    Key? key,
    required this.folderIndex,
  }) : super(key: key);

  int folderIndex;

  @override
  State<Addsongs> createState() => _AddsongsState();
}

class _AddsongsState extends State<Addsongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Row(
            children: const [
              Text(
                'Sarigama',
                style: TextStyle(
                    color: Color.fromARGB(255, 78, 11, 11), fontSize: 35.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 13.0),
                child: Text(
                  'Music',
                  style: TextStyle(
                      color: Color.fromARGB(255, 250, 250, 250),
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.search),
          //     tooltip: 'Search Songs',
          //     onPressed: () {
          //       // handle the press
          //     },
          //   ),
          // ],
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                PlaylistButton(
                                    index: index,
                                    folderindex: widget.folderIndex,
                                    id: MyHomeScreen.playlist[index].id),
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                      footer:  Container(
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
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          MyHomeScreen.playlist[index].title,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                    ),
                  ),
                  SizedBox(
                      height: 15,
                      child: Text(MyHomeScreen.playlist[index].title))
                ],
              );
            }));
  }
}
