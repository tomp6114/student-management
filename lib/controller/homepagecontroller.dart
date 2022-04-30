import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageController extends GetxController{
bool isSearch = false;
  Icon? cusIcon = const Icon(Icons.search);
  Widget? cusSearchBar = Text("Student Management",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),);
 changeIcon(Icon icon,Widget widget, bool state){
   cusIcon= icon;
   cusSearchBar = widget;
   isSearch = state;
   update();
 }


}
