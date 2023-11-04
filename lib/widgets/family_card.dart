import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String displayName;
  final String photoUrl;
  FriendCard({required this.displayName, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FCFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDFF1FF))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const SizedBox(height: 10,),
          Text(displayName),
        ],
      ),
    );
  }
}
