import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/providers/firebase_user_provider.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  late TextEditingController controller;
  String text = '';

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseUserProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your code: ${provider.user.familyID}'),
            TextField(
              controller: controller,
              onSubmitted: (String value){
                setState(() {
                  text = controller.text;
                });
              },
            ),
            const Text('Your Friends'),
          ],
        );
      },
    );
  }
}
