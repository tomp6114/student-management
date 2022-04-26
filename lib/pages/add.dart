import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/pages/image_view.dart';
import 'package:student_management/widgets/constants.dart';
import '../model/student.dart';
import '../widgets/baseappbar.dart';
import '../main.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var box = Hive.box<Student>(boxName);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  XFile? _image;
  dynamic _imagePath;
  final formKey = GlobalKey<FormState>();

  Future getImage() async {
    final ImagePicker image = ImagePicker();
    _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {});
      _imagePath = _image!.path;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBalckColor,
      appBar: BaseAppBar(
        centerTitle: true,
        title: const Text("Create"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Stack(
                children: [
                  _image == null
                      ? const CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey,
                          child: Text(
                            "Add Image",
                            style: TextStyle(color: kOrangeColor),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewImage(imagepath: _imagePath)));
                          },
                          child: ClipOval(
                              child: Image.file(
                            File(_imagePath),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: kOrangeColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: kBalckColor,
                        ),
                        onPressed: getImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 5 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: TextFieldCustom(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter name";
                    } else {
                      if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                          .hasMatch(value)) {
                        return "please enter a valid name";
                      }
                      return null;
                    }
                  },
                  controller: nameController,
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    child: TextFieldCustom(
                      keyboard: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter age";
                        } else {
                          if (RegExp(r'^[0-9]*$').hasMatch(value) &&
                              int.parse(value) < 150) {
                            return null;
                          } else {
                            return "invalid input";
                          }
                        }
                      },
                      controller: ageController,
                      labelText: 'Age',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    child: TextFieldCustom(
                      keyboard: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter class";
                        } else {
                          if (RegExp(r'^[0-9]*$').hasMatch(value) &&
                              value.length < 3) {
                            return null;
                          } else {
                            return "invalid input";
                          }
                        }
                      },
                      controller: classController,
                      labelText: 'Class',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: TextFieldCustom(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter place";
                    }
                    return null;
                  },
                  controller: placeController,
                  labelText: 'Place',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kBalckColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: Color.fromARGB(255, 89, 151, 39),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          box.add(Student(
                              name: nameController.text,
                              age: int.parse(ageController.text),
                              currentClass: int.parse(classController.text),
                              place: placeController.text,
                              imagePath: _imagePath));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Student Added Successfully"),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: kOrangeColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .35,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kBalckColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                color: Color.fromARGB(255, 89, 151, 39),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back",
                          style: GoogleFonts.montserrat(
                              color: kOrangeColor, fontSize: 16),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
