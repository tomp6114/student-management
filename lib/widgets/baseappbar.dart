
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';

import 'package:student_management/widgets/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  bool centerTitle = false;
  List<Widget>? actions;
  bool leadingback=false;

  BaseAppBar(
      {Key? key,
      this.title,
      this.centerTitle=false,
        this.actions, this.leadingback=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leadingback,
      title: title,
      centerTitle: centerTitle,
      titleTextStyle: const TextStyle(color: kOrangeColor, fontSize: 20),
      backgroundColor: kBalckColor,
      actions: actions,
      iconTheme:const  IconThemeData(color: kOrangeColor),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class TextFieldCustom extends StatelessWidget {
  final String labelText;
  TextEditingController? controller;
  String? initialvalue;
  FormFieldValidator<String>? validator;
  void Function(String)? onChanged;
  TextInputType? keyboard;

  TextFieldCustom({Key? key, required this.labelText,this.keyboard,  this.controller, this.initialvalue, this.validator,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.montserrat(color:kWhiteColor),
      keyboardType: keyboard??TextInputType.text,
      onChanged: onChanged,
      validator: validator,
      initialValue: initialvalue,
      decoration: InputDecoration(
        fillColor: kWhiteColor,
        labelText: labelText,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15)),
        labelStyle: const TextStyle(color: kGreyColor),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kOrangeColor),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kOrangeColor),
            borderRadius: BorderRadius.circular(15)),
      ),
      controller: controller,
    );
  }
}


