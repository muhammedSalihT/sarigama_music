import 'package:flutter/material.dart';

import 'colors.dart';

class ExMusic extends StatelessWidget {
  const ExMusic({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: backgroundgrd),
          ),
    );
  }
}