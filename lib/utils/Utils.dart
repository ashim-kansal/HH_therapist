//show Toast
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

showToast(BuildContext context, String message){
  Toast.show(message,
      context,
      duration: Toast.LENGTH_LONG,
      gravity:  Toast.BOTTOM);
}