import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/main.dart';
import 'package:student_management/model/student.dart';

class StudentController extends GetxController{
  Box<Student> allstudentscontroller = Hive.box(boxName);
  List<Student> list= [];

String? imagePath;
  getImage() async {
    final ImagePicker image = ImagePicker();
  final _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      imagePath = _image.path;
    }
    update();
  }
  updateStudent(List<Student> data) {
    list = data;
    print(list.length);
    update();

  }
}

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
  }
}