import 'dart:ui';

import 'package:flutter/material.dart';

Widget setupAlertDialog(context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        color: Colors.transparent,
        height: 180.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('List Item $index',style:const  TextStyle(color: Colors.white),),
              trailing: const Icon(Icons.add,color: Colors.white,),
            );
          },
        ),
      ),
      
      Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      )
    ],
  );
}
