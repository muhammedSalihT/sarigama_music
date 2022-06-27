import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarigama_music1/src/home/home_page.dart';
import 'package:sarigama_music1/src/home/home_screen.dart';

class MyMusic extends StatefulWidget {
  final List<SongModel> songs;

  const MyMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  State<MyMusic> createState() => _MyMusicState();
}

class _MyMusicState extends State<MyMusic> {
  DateTime timeBackPressed = DateTime.now();
  bool _isPlaying = false;
  final Duration _duration = const Duration();
  int currentIndex = 0;
  String currentTitle = '';
  int flag = 1;
  int tempindex = 666;

  Color _buttonColor1 = const Color.fromARGB(255, 78, 11, 11);
  Color _buttonColor2 = Colors.white;

  @override
  void initState() {
    super.initState();
    MyHomeScreen.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
    _duration;
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
        MyHomeScreen.audioPlayer.positionStream,
        MyHomeScreen.audioPlayer.durationStream,
        (position, duration) =>
            DurationState(position: position, total: duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = 'Press back again to exit from App';
          Fluttertoast.showToast(
              msg: message,
              fontSize: 18,
              backgroundColor: Color.fromARGB(188, 235, 229, 229));
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 209, 30, 30),
        body: Column(
          children: [
            Expanded(
              child: GridTile(
                child: _imageButton(),
                header: Container(
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
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Buttons(id: widget.songs[currentIndex].id),
                  //     IconButton(
                  //         icon: const Icon(
                  //           Icons.playlist_add,
                  //           color: Colors.white,
                  //         ),
                  //         onPressed: () {
                  //           final id = widget.songs[currentIndex].id;
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //                 builder: (context) => AddPlaylist(
                  //                       list: widget.songs[currentIndex],
                  //                       id: id,
                  //                     )),
                  //           );
                  //         }),
                  //   ],
                  // ),
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
                  widget.songs[currentIndex].title,
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
                  widget.songs[currentIndex].artist.toString() == '<unknown>'
                      ? "unknown Artist"
                      : widget.songs[currentIndex].artist.toString(),
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
                      final progress = durationState?.position ?? Duration.zero;
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
                      final progress = durationState?.position ?? Duration.zero;
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
            setState(
              () {
                _isPlaying = !_isPlaying;
              },
            );
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
            allsong = widget.songs;
            if (MyHomeScreen.audioPlayer.hasNext) {
              MyHomeScreen.audioPlayer.seekToNext();
            }
          },
        );
      },
    );
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(
      () {
        if (widget.songs.isNotEmpty) {
          currentTitle = widget.songs[index].title;
          currentIndex = index;
        }
      },
    );
  }

  _imageButton() {
    if (MyHomeScreen.playlist.isNotEmpty) {
      return QueryArtworkWidget(
          artworkQuality: FilterQuality.high,
          id: widget.songs[currentIndex].id,
          type: ArtworkType.AUDIO,
          artworkWidth: double.infinity,
          artworkHeight: MediaQuery.of(context).size.height * .5,
          artworkFit: BoxFit.fill,
          artworkBorder: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          nullArtworkWidget: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .5,
            child: Image.asset(
              "assets/images/image-removebg-preview.png",
            ),
          ));
    } else {
      return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .5,
          child: Image.asset('assets/images/image-removebg-preview.png'));
    }
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
