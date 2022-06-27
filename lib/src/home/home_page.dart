import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sarigama_music1/colors.dart';
import 'package:sarigama_music1/music_player.dart';
import '../../ex_music.dart';
import '../../favourite_screen.dart';
import 'home_screen.dart';
import '../../playlist-screen.dart';
import '../../user_screen.dart';

List<SongModel> allsong = MyHomeScreen.playlist;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  int currentIndex = 0;

  Widget get bodyFunction {
    switch (_page) {
      case 0:
        return const MyHomeScreen();

      case 1:
        return const MyFavouriteScreen();

      case 2:
        if (MyHomeScreen.playlist.isEmpty) {
          return const ExMusic();
        } else {
          return MyMusic(songs: allsong);
        }
      case 3:
        return const MyPlayListScreen();

      default:
        return const MyScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    MyHomeScreen.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: backgroundgrd),
          ),
          child: bodyFunction),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(214, 187, 166, 166),
        key: _bottomNavigationKey,
        items: <Widget>[
          SizedBox(
            height: 50.0,
            child: Column(
              children: const [Icon(Icons.home, size: 30), Text("Home")],
            ),
          ),
          SizedBox(
            height: 50.0,
            child: Column(
              children: const [
                Icon(Icons.favorite, size: 30),
                Text("Favorite")
              ],
            ),
          ),
          _imageButton(),
          SizedBox(
            height: 50.0,
            child: Column(
              children: const [
                Icon(Icons.playlist_play, size: 30),
                Text("PlayList")
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
            child: Column(
              children: const [Icon(Icons.person, size: 30), Text("Person")],
            ),
          ),
        ],
        index: 0,
        height: 50.0,
        buttonBackgroundColor: const Color.fromARGB(209, 78, 11, 11),
        backgroundColor: const Color.fromARGB(214, 187, 166, 166),
        animationCurve: Curves.ease,
        animationDuration: const Duration(milliseconds: 1200),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(
      () {
        if (allsong.isNotEmpty) {
          currentIndex = index;
        }
      },
    );
  }

  _imageButton() {
    if (MyHomeScreen.playlist.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: const Color.fromARGB(158, 187, 166, 166),
        radius: 27.0,
        child: QueryArtworkWidget(
          id: allsong[currentIndex].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget:
              Image.asset('assets/images/image-removebg-preview.png'),
          artworkBorder: BorderRadius.circular(30),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: const Color.fromARGB(158, 187, 166, 166),
        radius: 27.0,
        child: Image.asset('assets/images/image-removebg-preview.png'),
      );
    }
  }
}
