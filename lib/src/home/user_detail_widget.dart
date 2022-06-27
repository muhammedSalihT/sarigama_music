import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  String title;
  IconData iconData;
  
   UserDetailsWidget({Key? key,required this.iconData,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Icon(iconData,size: 40,),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
  
}
