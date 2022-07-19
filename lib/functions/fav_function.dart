import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';
import 'package:sarigama_music1/src/home/home_screen.dart';

class DbFav {
  static ValueNotifier<List<dynamic>> favourites = ValueNotifier([]);
  static List<dynamic> favsong = [];
  static List<SongModel> favloop = [];

  static addSongs(item) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.add(item);
    getAllsongs();
  }

  static getAllsongs() async {
    final boxdb = await Hive.openBox('favourites');
    favsong = boxdb.values.toList();
    favourites.value.reversed;
    displaySongs();
    favourites.notifyListeners();
  }

  static displaySongs() async {
    final boxdb = await Hive.openBox('favourites');
    final music = boxdb.values.toList();
    favourites.value.clear();
    favloop.clear();
    for (int i = 0; i < music.length; i++) {
      for (int j = 0; j < MyHomeScreen.playlist.length; j++) {
        if (music[i] == MyHomeScreen.playlist[j].id) {
          favourites.value.add(j);
          favloop.add(MyHomeScreen.playlist[j]);
          favourites.value.reversed;
          favloop.reversed;
        }
      }
    }
  }

  static deletion(index) async {
    final boxdb = await Hive.openBox('favourites');
    await boxdb.deleteAt(index);
    getAllsongs();
  }
}
