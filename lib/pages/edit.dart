import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/pages/image_view.dart';
import 'package:student_management/widgets/constants.dart';
import '../model/student.dart';
import '../widgets/baseappbar.dart';
import '../main.dart';

class Edit extends StatefulWidget {
  var box = Hive.box<Student>(boxName);
  final List<Student> obj;
  final int index;
  Edit({Key? key, required this.obj, required this.index,}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  XFile? _image;
  dynamic _imagePath;
  final formKey = GlobalKey<FormState>();
  int? newindex;
  int? newkey;
  int? accesskey;

  prefilledDetails() {
    nameController.text = widget.obj[widget.index].name;
    ageController.text = widget.obj[widget.index].age.toString();
    classController.text = widget.obj[widget.index].currentClass.toString();
    placeController.text = widget.obj[widget.index].place;
    _imagePath = widget.obj[widget.index].imagePath;
    newkey = widget.obj[widget.index].key;
    List<Student> hello = widget.box.values.toList();
    for(int i=0;i<hello.length;i++){
      if(hello[i].key==newkey){
        accesskey = i;
        break;
      }
    }

  }

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
  void initState() {
    prefilledDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Stack(
                children: [
                  _imagePath == null
                      ? const CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey,
                          child: Text(
                            "Add Image",
                            style: TextStyle(color: kOrangeColor),
                          ),
                        )
                      : GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> ViewImage(imagepath: _imagePath)));
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
                  onChanged: (value) {
                  },
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
                      onChanged: (value) {
                      },
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
                      onChanged: (value) {
                      },
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
                  onChanged: (value) {
                  },
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
                    child: ElevatedButton(
                      style:ButtonStyle(
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
                            widget.box.putAt(
                                accesskey!,
                                Student(
                                    name: nameController.text,
                                    age: int.parse(ageController.text),
                                    currentClass: int.parse(classController.text),
                                    place: placeController.text,
                                    imagePath: _imagePath));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Student edited Successfully")));
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 89, 151, 39),
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: kRedColor,
                            ),
                          ),
                        ),
                      ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete"),
                                  content: const Text("Do you want to delete it?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          widget.obj[widget.index].delete();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Student deleted Successfully")));
                                        },
                                        child:const  Text("Yes"))
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: kRedColor, fontSize: 16),
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
