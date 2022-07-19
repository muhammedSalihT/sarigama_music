import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sarigama_music1/single_playlist.dart';
import 'functions/playlist_fun.dart';
import 'model/playlist_mod.dart';

class MyPlayListScreen extends StatefulWidget {
  const MyPlayListScreen({Key? key}) : super(key: key);

  @override
  State<MyPlayListScreen> createState() => _MyPlayListScreenState();
}

class _MyPlayListScreenState extends State<MyPlayListScreen> {
  DateTime timeBackPressed = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPlaylist();
  }

  final TextEditingController _textFieldController = TextEditingController();
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
                    'Playlist',
                    style: TextStyle(
                        color: Color.fromARGB(255, 250, 250, 250),
                        fontSize: 15.0),
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.playlist_add,
                  size: 35,
                ),
                tooltip: 'Make New Playlist',
                onPressed: () {
                  _displayTextInputDialog(context);
                },
              ),
            ],
          ),
          body: ValueListenableBuilder(
              valueListenable: playListNotifier,
              builder: (BuildContext ctx, List<PlayListModel> playList,
                  Widget? child) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    itemCount: playList.length,
                    itemBuilder: (context, index) {
                      final data = playList[index];
                      return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/playstore.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: GridTile(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SinglePlaylist(folderIndex: index),
                                ));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(2, 37, 35, 35),
                                        Color.fromARGB(37, 0, 0, 0)
                                      ]),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(40, 37, 35, 35),
                                          Color.fromARGB(226, 0, 0, 0)
                                        ]),
                                  ),
                                  child: Center(
                                    child: Text(data.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                183, 255, 255, 255),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            footer: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          backgroundColor:
                                              const Color.fromARGB(15, 0, 0, 0),
                                          // title: const Text(
                                          //     'do you want to remove the song?'),
                                          content: const Text(
                                            'Do you want to remove the playlist?',
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
                                                  deleteplaylist(index);
                                                  const snackBar = SnackBar(
                                                      duration:
                                                          Duration(seconds: 1),
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
                                  alignment: Alignment.centerRight,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ));
                    });
              })),
    );
  }

  _displayTextInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: "Add Name",
                hintStyle: TextStyle(color: Color.fromARGB(137, 255, 255, 255)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 240, 240, 240), width: 2.0),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _textFieldController.clear();
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => MyPlayListScreen()));
                },
              ),
              TextButton(
                child: Text('CREATE'),
                onPressed: () {
                  final _name = _textFieldController.text.trim();
                  if (_name.isNotEmpty) {
                    final _newList = PlayListModel(name: _name, songListdb: []);
                    addPlayList(_newList);
                    _textFieldController.clear();
                    print(_newList);
                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => MyPlayListScreen(),
                    ));
                  } else {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) => MyPlayListScreen()));
                  }
                },
              ),
            ],
          );
        });
  }
}
