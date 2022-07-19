import 'package:flutter/material.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';
import 'package:sarigama_music1/functions/playlist_fun.dart';
import 'package:sarigama_music1/model/playlist_mod.dart';
import 'package:sarigama_music1/src/home/home_screen.dart';

// ignore: must_be_immutable
class AddPlaylist extends StatefulWidget {
  int id;
  final SongModel list;
  AddPlaylist({
    Key? key,
    required this.list,
    required this.id,
  }) : super(key: key);

  @override
  State<AddPlaylist> createState() => _AddPlaylistState();
}

class _AddPlaylistState extends State<AddPlaylist> {
  final TextEditingController _textFieldController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(0, 209, 30, 30),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(0, 137, 47, 47),
            title: Row(
              children: const [
                Text(
                  'sarigama',
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
                          shape: BoxShape.rectangle,
                        ),
                        child: GridTile(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(47, 0, 0, 0),
                                    Color.fromARGB(103, 0, 0, 0)
                                  ]),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 7),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 50,
                                  color: Color.fromARGB(94, 255, 255, 255),
                                ),
                                onPressed: () {
                                  if (playListNotifier.value[index].songListdb
                                      .contains(widget.id)) {
                                    Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomeScreen(),
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          ' ${widget.list.title}already in ${playListNotifier.value[index].name}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 68, 68, 68),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    playListNotifier.value[index].songListdb
                                        .add(widget.id);
                                    Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomeScreen(),
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          ' ${widget.list.title}Added To Playlist ${playListNotifier.value[index].name}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 68, 68, 68),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          footer: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(data.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(139, 255, 255, 255),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      );
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
            content: TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: "Playlist Name",
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
                child: const Text('CANCEL'),
                onPressed: () {
                  _textFieldController.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('CREATE'),
                  onPressed: () {
                    final _name = _textFieldController.text.trim();
                    if (_name.isNotEmpty) {
                      final _newList =
                          PlayListModel(name: _name, songListdb: []);
                      addPlayList(_newList);
                      print(_newList);
                      _textFieldController.clear();
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  })
            ],
          );
        });
  }
}
