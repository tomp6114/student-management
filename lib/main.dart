import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/pages/splash_screen.dart';
import 'package:student_management/widgets/constants.dart';
import 'model/student.dart';
const boxName = 'box_name';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(StudentAdapter());
    await Hive.openBox<Student>(boxName);
    runApp(const StudentManagement());
}

class StudentManagement extends StatelessWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        textTheme: TextTheme(bodyMedium: GoogleFonts.montserrat(color:kWhiteColor)),
        primaryColor: kWhiteColor,
        iconTheme: const IconThemeData(
          color: kOrangeColor
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

