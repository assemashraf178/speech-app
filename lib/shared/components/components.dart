import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blueGrey,
  bool isUpperCase = true,
  double radius = 15.0,
  double height = 40.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        hoverElevation: 10.0,
        focusElevation: 25.0,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 50.0,
      ),
    );

Widget defaultTextFormField({
  required String hint,
  required IconData prefixIcon,
  required BuildContext context,
  required TextInputType type,
  required Function validator,
  required TextEditingController controller,
  bool isPassword = false,
  IconButton? suffixIcon,
  Function? onChange,
  Function? onSubmit,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey.withOpacity(0.1),
      ),
      child: TextFormField(
        maxLines: 3,
        minLines: 1,
        onFieldSubmitted: (s) {
          onSubmit!(s);
        },
        onChanged: (s) {
          onChange!(s);
        },
        controller: controller,
        validator: (value) {
          validator(value);
        },
        keyboardType: type,
        obscureText: isPassword,
        style: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixStyle: const TextStyle(
            color: Colors.white,
          ),
          suffix: suffixIcon,
          contentPadding: EdgeInsets.all(
            (MediaQuery.of(context).size.width) / 50.0,
          ),
          isCollapsed: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          labelText: hint,
        ),
      ),
    );

void initFun({
  required List<PopupMenuEntry<Languages>> items,
}) {
  for (Languages lang in Languages.values) {
    items.add(PopupMenuItem(
      child: Text(
        lang == Languages.ar ? 'Arabic' : 'English',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      value: lang,
    ));
  }
}
