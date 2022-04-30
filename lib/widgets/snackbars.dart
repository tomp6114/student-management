import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/student.dart';
import 'constants.dart';

Future<dynamic> deleteDialog(List<Student> data, int index) {
    return Get.defaultDialog(
      barrierDismissible: false,
      titleStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
      title: "Delete",
      content: Text(
        "Do you want to delete it?",
        style: GoogleFonts.montserrat(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "No",
            style: GoogleFonts.montserrat(),
          ),
        ),
        TextButton(
          onPressed: () {
            data[index].delete();
            Get.back();
            Get.snackbar(
              "Warning",
              "Student deleted Successfully",
              colorText: Colors.red,
              borderRadius: 10,
            );
          },
          child: Text(
            "Yes",
            style: GoogleFonts.montserrat(),
          ),
        )
      ],
    );
  }

  SnackbarController studentAddedSnackBar() => Get.snackbar("Message", "Student Added Successfully",borderRadius: 10,colorText: kGreenColor);
  SnackbarController deleteStudentSnackbar() => Get.snackbar("Message", "Student deleted Successfully",borderRadius: 10,colorText: kRedColor);
