import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/controller/controller.dart';
import 'package:student_management/pages/image_view.dart';
import 'package:student_management/widgets/constants.dart';
import '../model/student.dart';
import '../widgets/baseappbar.dart';
import '../main.dart';
import '../widgets/snackbars.dart';

class Edit extends StatelessWidget {
  var box = Hive.box<Student>(boxName);
  final List<Student> obj;
  final int index;
  Edit({
    Key? key,
    required this.obj,
    required this.index,
  }) : super(key: key);

  //StudentController s = StudentController();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  // XFile? _image;
  String imagePath = '';
  final formKey = GlobalKey<FormState>();
  int? newindex;
  int? newkey;
  int? accesskey;

  prefilledDetails() {
    nameController.text = obj[index].name;
    ageController.text = obj[index].age.toString();
    classController.text = obj[index].currentClass.toString();
    placeController.text = obj[index].place;
    imagePath = obj[index].imagePath;
    newkey = obj[index].key;

    List<Student> hello = box.values.toList();
    for (int i = 0; i < hello.length; i++) {
      if (hello[i].key == newkey) {
        accesskey = i;
        break;
      }
    }
  }

  // Future getImage() async {
  //   final ImagePicker image = ImagePicker();
  //   _image = await image.pickImage(source: ImageSource.gallery);
  //   if (_image != null) {
  //     imagePath = _image!.path;
  //   }
  //   return null;
  // }
  final StudentController _image = Get.find();

  @override
  Widget build(BuildContext context) {
    prefilledDetails();
    return Scaffold(
      backgroundColor: kBalckColor,
      appBar: BaseAppBar(
        leadingback: true,
        centerTitle: true,
        title: const Text("Edit"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              GetBuilder<StudentController>(
                builder: (controller) {
                  print("...........................${controller.imagePath}");
                  return Stack(
                    children: [
                      (controller.imagePath == null)
                          ? const CircleAvatar(
                              child: Center(
                                child: Text("Add Image"),
                              ),
                              radius: 80,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(controller.imagePath!),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
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
                            onPressed: () {
                              controller.getImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 5 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: TextFieldCustom(
                  onChanged: (value) {},
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
                  labelText: 'Name',
                  controller: nameController,
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
                      onChanged: (value) {},
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
                      labelText: 'Age',
                      controller: ageController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 10 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    child: TextFieldCustom(
                      keyboard: TextInputType.number,
                      onChanged: (value) {},
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
                      labelText: 'Class',
                      controller: classController,
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
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter place";
                    }
                    return null;
                  },
                  labelText: 'Place',
                  controller: placeController,
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
                    child: GetBuilder<StudentController>(
                     
                      builder: (control) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kBalckColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            if (formKey.currentState!.validate()) {
                              box.putAt(
                                accesskey!,
                                updateStudent(),
                              );
                              control.update();
                              Get.back();
                              Get.snackbar(
                                "Message",
                                "Student edited Successfully",
                                borderRadius: 10,
                                colorText: kGreenColor,
                              );
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 89, 151, 39),
                            ),
                          ),
                        );
                      },
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: kRedColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        deleteStudentDialog();
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: kRedColor, fontSize: 16),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Student updateStudent() {
    return Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      currentClass: int.parse(classController.text),
      place: placeController.text,
      imagePath: _image.imagePath,
    );
  }

  Future<dynamic> deleteStudentDialog() {
    return Get.defaultDialog(
      title: "Delete",
      titleStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
      middleText: "Do you want to delete it ?",
      middleTextStyle: GoogleFonts.montserrat(),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("No")),
        TextButton(
          onPressed: () {
            obj[index].delete();
            Get.back();
            deleteStudentSnackbar();
          },
          child: const Text("Yes"),
        )
      ],
    );
  }
}
