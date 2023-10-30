import 'package:flutter/material.dart';
import 'package:familyfridge/text_styles.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.black26,
          ),
        ),
        backgroundColor: const Color(0xFFF2ECEC),
        minimumSize: const Size(20, 50),
        elevation: 0,
      ),
      child: const Text('Log in', style: kLandingPageLogInButtonTextStyle,),
    );
  }
}
