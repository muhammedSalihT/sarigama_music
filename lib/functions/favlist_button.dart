import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  final DbFavController dbFavController = Get.find();
  Buttons({Key? key, this.id}) : super(key: key);
  dynamic id;

  @override
  Widget build(BuildContext context) {
    final lastIndex = dbFavController.favsong.indexWhere((element) => element == id);
    final checkIndex = dbFavController.favsong.contains(id);

    if (checkIndex == true) {
      return IconButton(
          onPressed: () async {
            await dbFavController.deletion(lastIndex);
            
            const snackbar = SnackBar(
              content: Text('remove from favourites'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          icon: const Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 176, 13, 13),
          ));
    }
    return IconButton(
        onPressed: () async {
          await dbFavController.addSongs(id);

          const snackBar = SnackBar(
            content: Text('add to favorites '),
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        icon: const Icon(Icons.favorite_border_outlined, color: Colors.grey));
  }
}
