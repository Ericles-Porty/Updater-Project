import 'package:flutter/material.dart';

Widget myElevatedButton({required VoidCallback onPressed, required Widget child, }) {
  return ElevatedButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(200, 50)),
      alignment: Alignment.center,
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.green),
    ),
    onPressed: onPressed,
    child: child,
  );
}
