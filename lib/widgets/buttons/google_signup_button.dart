import 'package:flutter/material.dart';
import 'package:familyfridge/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/providers/google_signin_provider.dart';

class GoogleSignUpButton extends StatelessWidget {
  const GoogleSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(10,60),
        backgroundColor: const Color(0xFFF2ECEC),
        shadowColor: const Color(0xFF71C9CE),
        side: const BorderSide(
          color: Colors.black26,
        ),
        elevation: 0,
      ),
      onPressed: () {
        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin();
        Navigator.pushNamed(context, '/logging');
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundImage: AssetImage('assets/images/GoogleLogo.png'), backgroundColor: Color(0x100FFFFF), radius: 13,),
          SizedBox(
            width: 10,
          ),
          Text('Sign up with Google', style: kLandingPageGoogleButtonTextStyle,)
        ],
      ),
    );
  }
}
