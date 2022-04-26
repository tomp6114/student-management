import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/pages/alldetails.dart';
import 'package:student_management/pages/add.dart';
import 'package:student_management/pages/edit.dart';
import 'package:student_management/main.dart';
import 'package:student_management/widgets/baseappbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

import 'package:student_management/widgets/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = const Text("Student Management");
  String searchtext = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBalckColor,
      appBar: BaseAppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (cusIcon.icon == Icons.search) {
                    cusIcon = const Icon(Icons.close);
                    cusSearchBar = TextField(
                      autofocus: true,
                      onChanged: (value) {
                        searchtext = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: kOrangeColor)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: kOrangeColor)),
                          hintText: "Search",
                          hintStyle: GoogleFonts.montserrat(
                            color: kGreyColor,
                          )),
                      style: GoogleFonts.montserrat(
                        color: kOrangeColor,
                        fontSize: 20,
                      ),
                    );
                  } else {
                    setState(() {
                      searchtext = "";
                    });
                    cusIcon = const Icon(Icons.search);
                    cusSearchBar = const Text("Student Management");
                  }
                });
              },
              icon: cusIcon)
        ],
        title: cusSearchBar,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Student>(boxName).listenable(),
        builder: (context, Box<Student> newbox, _) {
          List key = newbox.keys.toList();
          if (key.isEmpty) {
            return const Center(
              child: Text("The Student List is Empty"),
            );
          } else {
            List<Student> data = newbox.values
                .toList()
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchtext.toLowerCase()))
                .toList();
            if (data.isEmpty) {
              return const Center(
                  child: Text(
                "No results found",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ));
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        tileColor: Colors.transparent.withOpacity(1),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllDetails(
                                obj: data,
                                index: index,
                              ),
                            ),
                          );
                        },
                        leading: data[index].imagePath == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Text(
                                  "No Image",
                                  style: TextStyle(
                                      fontSize: 8, color: kOrangeColor),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Edit(
                                      obj: data,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: kGreyColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete"),
                                      content: const Text(
                                          "Do you want to delete it?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            data[index].delete();
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Student deleted Successfully"),
                                              ),
                                            );
                                          },
                                          child: const Text("Yes"),
                                        )
                                      ],
                                    );
                                  },
                                );
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
                  itemCount: data.length),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOrangeColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Details()));
        },
        child: const Icon(
          Icons.add,
          color: kBalckColor,
        ),
      ),
    );
  }
}
