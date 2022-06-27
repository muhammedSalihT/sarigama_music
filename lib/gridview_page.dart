import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  final controller = ScrollController();

  // bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 40,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        controller: controller,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: AssetImage('assets/images/86325040_300x300.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
            child: GridTile(
              child: const Icon(
                Icons.play_arrow,
                size: 60,
                color: Color.fromARGB(170, 0, 0, 0),
              ),
              footer: Container(
                height: 40.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                  color: Color.fromARGB(65, 10, 5, 5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.favorite,
                        size: 30,
                        color: Color.fromARGB(162, 255, 255, 255),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Icon(Icons.playlist_add_check,
                          size: 40, color: Color.fromARGB(162, 255, 255, 255))
                    ],
                  ),
                ),
                
              ),
              header: Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Container(color: Colors.blue),
              ),

            ),
          );
        });
  }
}
