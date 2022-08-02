import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';
import 'package:sarigama_music1/models/playlist_mod.dart';
import 'package:sarigama_music1/views/home_screen.dart';

ValueNotifier<List<PlayListModel>> playListNotifier = ValueNotifier([]);
List<SongModel> playloop = [];

void addPlayList(PlayListModel value) async {
  final playListDB = await Hive.openBox<PlayListModel>('playlist_db');
  int _id = await playListDB.add(value);
  value.id = _id;
  playListNotifier.value.add(value);
  playListNotifier.notifyListeners();
}

Future<void> getAllPlaylist() async {
  final playListDB = await Hive.openBox<PlayListModel>('playlist_db');
  playListNotifier.value.clear();
  playListNotifier.value.addAll(playListDB.values);
  playListNotifier.notifyListeners();
}

updatlist(index, value) async {
  final playListDB = await Hive.openBox<PlayListModel>('playlist_db');
  await playListDB.putAt(index, value);
  await getAllPlaylist();
  await Playlistsongcheck.showSelectSong(index);
}

deleteplaylist(index) async {
  final playListDB = await Hive.openBox<PlayListModel>('playlist_db');
  await playListDB.deleteAt(index);
  await getAllPlaylist();
}

resetApp() async {
  final playListDB = await Hive.openBox<PlayListModel>('playlist_db');
  final boxdb = await Hive.openBox('favourites');
  await playListDB.clear();
  await boxdb.clear();
  MyHomeScreen.audioPlayer.pause();
}

class Playlistsongcheck {
  static ValueNotifier<List> selectPlaySong = ValueNotifier([]);
  static showSelectSong(index) async {
    final checkSong = playListNotifier.value[index].songListdb;
    selectPlaySong.value.clear();
    playloop.clear();
    for (int i = 0; i < checkSong.length; i++) {
      for (int j = 0; j < MyHomeScreen.playlist.length; j++) {
        if (MyHomeScreen.playlist[j].id == checkSong[i]) {
          selectPlaySong.value.add(j);
          playloop.add(MyHomeScreen.playlist[j]);
          break;
        }
      }
    }
  }
}
