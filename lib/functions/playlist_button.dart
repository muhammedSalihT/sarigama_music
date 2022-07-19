import 'package:flutter/material.dart';
import 'package:sarigama_music1/functions/playlist_fun.dart';
import 'package:sarigama_music1/src/home/home_screen.dart';
import '../model/playlist_mod.dart';

// ignore: must_be_immutable
class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.id})
      : super(key: key);

  int? index;
  int? folderindex;
  int? id;
  List<dynamic> songlist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];

  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
    final checkIndex = playListNotifier.value[widget.folderindex!].songListdb
        .contains(widget.id);
    final indexCheck = playListNotifier.value[widget.folderindex!].songListdb
        .indexWhere((element) => element == widget.id);
    if (checkIndex != true) {
      return IconButton(
          onPressed: () async {
            widget.songlist.add(widget.id);
            List<dynamic> newlist = widget.songlist;
            PlaylistButton.updatelist = [
              newlist,
              playListNotifier.value[widget.folderindex!].songListdb
            ].expand((element) => element).toList();
            final model = PlayListModel(
              name: playListNotifier.value[widget.folderindex!].name,
              songListdb: PlaylistButton.updatelist,
            );
            updatlist(widget.folderindex, model);
            getAllPlaylist();
            Playlistsongcheck.showSelectSong(widget.folderindex);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(
                  'added ${MyHomeScreen.playlist[indexCheck].title} to ${playListNotifier.value[widget.folderindex!].name},',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(
            Icons.playlist_add_circle_rounded,
            size: 35,
            color: Color.fromARGB(234, 231, 83, 72),
          ));
    }
    return IconButton(
        onPressed: () async {
          await playListNotifier.value[widget.folderindex!].songListdb
              .removeAt(indexCheck);
          PlaylistButton.dltlist = [
            widget.songlist,
            playListNotifier.value[widget.folderindex!].songListdb
          ].expand((element) => element).toList();
          final model = PlayListModel(
            name: playListNotifier.value[widget.folderindex!].name,
            songListdb: PlaylistButton.dltlist,
          );
          updatlist(widget.folderindex, model);
          Playlistsongcheck.showSelectSong(widget.folderindex);

          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'song deleted from   ${playListNotifier.value[widget.folderindex!].name},',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromARGB(255, 68, 68, 68),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(
          Icons.playlist_add_check_circle,
          size: 35,
          color: Color.fromARGB(255, 135, 255, 145),
        ));
  }
}
