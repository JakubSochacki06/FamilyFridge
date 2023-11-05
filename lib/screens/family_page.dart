import 'package:familyfridge/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:familyfridge/providers/firebase_user_provider.dart';
import 'package:familyfridge/text_styles.dart';
import 'package:familyfridge/widgets/family_card.dart';

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
    DatabaseService db = DatabaseService();
    return Consumer<FirebaseUserProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Your code: ',
                  style: kFamilyPageMainTextStyle,
                  children: [
                    TextSpan(
                        text: provider.user.familyID,
                        style: kFamilyPageCodeTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF71C9CE), width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        hintText: 'Enter friend\'s code here!',
                        hintStyle: const TextStyle(color: Colors.black12),
                      ),
                      onSubmitted: (String value) {
                        setState(() {
                          text = controller.text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async{
                        DatabaseService db = DatabaseService();
                        db.updateDatabase();
                        await db.addUserToFamily(provider.user.email!, controller.text, provider.user.familyID!);
                        await db.insertUserData(provider.user.email!, 'familyID', controller.text);
                        provider.changeFamilyID(controller.text);
                        controller.clear();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFFF4745B),
                        minimumSize: const Size(20, 50),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Submit',
                        style: kLandingPageSignUpButtonTextStyle,
                      ),
                    ),
                  )
                ],
              ),
              const Text('Your Fridge Family', style: kFamilyPageMainTextStyle,),
              Expanded(
                child: FutureBuilder(
                  future: db.getFriends(provider.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (_, index) {
                            return FriendCard(
                                displayName: provider.user.displayName == snapshot.data![index].displayName! ? '${snapshot.data![index].displayName} (You)' : snapshot.data![index].displayName!,
                                photoUrl: snapshot.data![index].photoURL!,
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
