import 'package:flutter/material.dart';

void SendMessage({required BuildContext context, required String message})
{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Container(
      width: 200,
      height: 50,
      child: Center(
        child: Text(message) ,
      ),
    ))
  );
}