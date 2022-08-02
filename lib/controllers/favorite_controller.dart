import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';
import 'package:sarigama_music1/views/home_screen.dart';

class DbFavController extends GetxController {
  @override
  void onInit() {
    getAllsongs();
    super.onInit();
  }

   List<dynamic> favourites = [].obs;
  List<dynamic> favsong = [];
  List<SongModel> favloop = [];

   addSongs(item) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.add(item);
    getAllsongs();
  }

   getAllsongs() async {
    final boxdb = await Hive.openBox('favourites');
    favsong = boxdb.values.toList();
    favourites.reversed;
    displaySongs();
    favourites;
  }

   displaySongs() async {
    final boxdb = await Hive.openBox('favourites');
    final music = boxdb.values.toList();
    favourites.clear();
    favloop.clear();
    for (int i = 0; i < music.length; i++) {
      for (int j = 0; j < MyHomeScreen.playlist.length; j++) {
        if (music[i] == MyHomeScreen.playlist[j].id) {
          favourites.add(j);
          favloop.add(MyHomeScreen.playlist[j]);
          favourites.reversed;
          favloop.reversed;
        }
      }
    }
  }

   deletion(index) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.deleteAt(index);
    getAllsongs();
  }
}
