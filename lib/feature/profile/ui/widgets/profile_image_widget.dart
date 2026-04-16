import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const CircleAvatar(
            radius: 65,
            backgroundColor: Color(0xFFE0E0E0),
            // backgroundImage: AssetImage('assets/images/user_placeholder.png'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 20,
              color: Color(0xFFB89F5D),
            ),
          ),
        ],
      ),
    );
  }
}
