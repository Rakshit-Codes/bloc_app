import 'package:flutter/material.dart';

void showSnackBar(BuildContext context , String constent){
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(constent)));
}