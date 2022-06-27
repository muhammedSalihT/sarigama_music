import 'package:flutter/material.dart';

class ShowDialog extends StatefulWidget {
  // Widget tapfun;
   final Function onpre;
   ShowDialog({Key? key,required this.onpre}) : super(key: key);

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(15, 0, 0, 0),
      content: const Text(
        'Do you want to remove the song?',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: widget.onpre(),
            child: const Text('Yes'))
      ],
    );
  }
}
