import 'package:flutter/material.dart';
import 'dart:io';

import 'package:student_management/widgets/constants.dart';

class ViewImage extends StatelessWidget {
  final String imagepath;
  const ViewImage({Key? key, required this.imagepath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          size: 35,
          color: kOrangeColor,
        ),
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              child: Image.file(
                File(imagepath),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
