import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_management/pages/image_view.dart';
import 'package:student_management/widgets/constants.dart';
import '../model/student.dart';
import '../main.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_management/widgets/baseappbar.dart';

class AllDetails extends StatelessWidget {
  final box = Hive.box<Student>(boxName);
  final List<Student> obj;
  final int index;

  AllDetails({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBalckColor,
      appBar: BaseAppBar(
        leadingback: true,
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kHeight30,
          Container(
            decoration: const BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: obj[index].imagePath == null
                ? const Text("No Image",
                    style: TextStyle(fontSize: 25, color: kOrangeColor))
                : GestureDetector(
                    onTap: () {
                      Get.to(ViewImage(
                        imagepath: obj[index].imagePath,
                      ));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.file(
                        File(obj[index].imagePath),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            obj[index].name,
            style: const TextStyle(fontSize: 35, color: kDeepOrange),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHeight30,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Class : ",
                    style: TextStyle(color: kGreyColor, fontSize: 22),
                  ),
                  kHeight12,
                  Text(
                    "Age    : ",
                    style: TextStyle(color: kGreyColor, fontSize: 22),
                  ),
                  kHeight12,
                  Text(
                    "Place : ",
                    style: TextStyle(color: kGreyColor, fontSize: 22),
                  ),
                ],
              ),
              kHeight30,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight5,
                  Text(
                    obj[index].currentClass.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 22, color: kOrangeColor),
                  ),
                  kHeight12,
                  Text(
                    obj[index].age.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 22, color: kOrangeColor),
                  ),
                  kHeight12,
                  Text(
                    obj[index].place,
                    style: GoogleFonts.montserrat(
                        fontSize: 22, color: kOrangeColor),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
