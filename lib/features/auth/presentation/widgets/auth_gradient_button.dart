import 'package:bloc_app/core/utils/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  const AuthGradientButton({super.key, required this.text, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppPallete.gradient1,
          AppPallete.gradient2
        ],
        begin:Alignment.bottomLeft,
        end: Alignment.topRight ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(text,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          fixedSize: Size(395, 55),
        ),
      ),
    );
  }
}