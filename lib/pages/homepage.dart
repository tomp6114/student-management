import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management/controller/controller.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/pages/alldetails.dart';
import 'package:student_management/pages/add.dart';
import 'package:student_management/pages/edit.dart';
import 'package:student_management/widgets/constants.dart';
import '../controller/homepagecontroller.dart';
import '../widgets/snackbars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchtext = "";
  final textController = TextEditingController();
  List<Student> data = [];

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    Get.put(StudentController());
    return Scaffold(
      backgroundColor: kBalckColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: GetBuilder<HomePageController>(
          builder: (controller) {
            return AppBar(
              foregroundColor: kOrangeColor,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: controller.cusSearchBar,
              actions: [],
              //iconTheme:const  IconThemeData(color: kOrangeColor),
            );
          },
        ),
      ),
      body: GetBuilder<StudentController>(
        builder: (controller) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: kGreyColor),
                      color: Color.fromARGB(255, 12, 12, 12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      showCursor: false,
                      style: GoogleFonts.montserrat(color: kWhiteColor),
                      onChanged: (value) {
                        searchtext = value;
                        controller.update();
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "      Search",
                          style: TextStyle(
                              color: kOrangeColor.withOpacity(0.5),
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GetBuilder<StudentController>(
                    builder: (_controller) {
                      List<Student> results = searchtext.isEmpty
                          ? _controller.allstudentscontroller.values.toList()
                          : _controller.allstudentscontroller.values
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(searchtext.toLowerCase()))
                              .toList();
                      if (results.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              "No data available",
                              style: GoogleFonts.montserrat(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (results[index].imagePath != null) {}
                          return Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 15, right: 20),
                            child: ListTile(
                              minVerticalPadding: 25,
                              tileColor: kWhiteColor.withOpacity(0.1),
                              onTap: () {
                                Get.to(() =>
                                    AllDetails(obj: results, index: index));
                              },
                              title: Text(
                                results[index].name,
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              ),
                              leading: results[index].imagePath == null
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                        "No Image",
                                        style: TextStyle(
                                            fontSize: 8, color: kOrangeColor),
                                      ),
                                    )
                                  : Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                                    child: Image.file(
                                      File(results[index].imagePath),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.to(Edit(obj: results, index: index));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: kGreyColor,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteDialog(results, index);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: kGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOrangeColor,
        onPressed: () {
          Get.to(Details());
        },
        child: const Icon(
          Icons.add,
          color: kBalckColor,
        ),
      ),
    );
  }

  ListView studentListView(List<Student> data, sudent) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            visualDensity: const VisualDensity(vertical: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            tileColor: Colors.transparent.withOpacity(1),
            onTap: () {
              Get.to(AllDetails(
                obj: data,
                index: index,
              ));
            },
            leading: data[index].imagePath == null
                ? const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      "No Image",
                      style: TextStyle(fontSize: 8, color: kOrangeColor),
                    ),
                  )
                : CircleAvatar(
                    child: ClipOval(
                      child: Image.file(
                        File(data[index].imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(Edit(obj: data, index: index));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: kGreyColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteDialog(data, index);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: kGreyColor,
                  ),
                ),
              ],
            ),
            title: Text(
              data[index].name,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: kWhiteColor,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return kHeight10;
      },
      itemCount: data.length,
    );
  }
}
