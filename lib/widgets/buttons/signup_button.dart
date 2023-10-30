import 'package:flutter/material.dart';
import 'package:familyfridge/text_styles.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: const Color(0xFFF4745B),
        minimumSize: const Size(20, 50),
        elevation: 0,
      ),
      child: const Text('Sign up', style: kLandingPageSignUpButtonTextStyle,),
    );
  }
}
