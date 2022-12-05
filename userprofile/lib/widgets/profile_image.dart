import 'package:flutter/material.dart';
import 'package:userprofile/utility/firebase/storage_service.dart';

import '../utility/utility_barrel.dart';

class ProfileImage extends StatefulWidget {
  final String profileImage;
  const ProfileImage({super.key, required this.profileImage});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final double coverHeight = 150;
  final double profileHeight = 150;

  String profileImageURL =
      "https://www.uoftbookstore.com/sca-dev-2021-1-0/img/no_image_available.jpeg";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImage(context, widget.profileImage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(profileImageURL),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: profileHeight,
            width: profileHeight,
            child: const CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FirebaseService.loadImage(context, imageName).then((value) {
      profileImageURL = value;
      image = Image.network(
        value.toString(),
        fit: BoxFit.cover,
      );
    });
    return image;
  }
}
