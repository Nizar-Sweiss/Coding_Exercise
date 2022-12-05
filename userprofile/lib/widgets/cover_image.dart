import 'package:flutter/material.dart';
import 'package:userprofile/utility/firebase/storage_service.dart';

import '../utility/utility_barrel.dart';

class CoverImage extends StatefulWidget {
  final String coverImage;
  final bool? isEdit;
  const CoverImage({super.key, required this.coverImage, this.isEdit});

  @override
  State<CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<CoverImage> {
  final double coverHeight = 150;
  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _getImage(context, widget.coverImage),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                margin: EdgeInsets.only(bottom: profileHeight / 2),
                width: double.infinity,
                height: coverHeight,
                child: snapshot.data,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: double.infinity,
                height: coverHeight,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FirebaseService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.cover,
      );
    });
    return image;
  }
}
