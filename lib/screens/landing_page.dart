import 'package:flutter/material.dart';
import 'package:familyfridge/widgets/buttons/google_signup_button.dart';
import 'package:familyfridge/widgets/buttons/login_button.dart';
import 'package:familyfridge/widgets/buttons/signup_button.dart';
import 'package:familyfridge/text_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset('assets/images/FamilyFridgeLandingPage.png'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LogInButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  SignUpButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'or',
                    // style: kLandingPageParagraphTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const GoogleSignUpButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
