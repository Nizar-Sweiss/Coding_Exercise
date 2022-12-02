import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _nameState();
}

class _nameState extends State<ProfileInfoScreen> {
  final double coverHeight = 280;

  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    final topPosition = coverHeight -
        profileHeight /
            2; //to position the profile image between the cover image and the contents info
    final bottom = profileHeight / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Info"),
        //title postion in the middle of the App Bar
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.language))
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: bottom),
                child: Container(
                  color: Colors.grey,
                  child: Image.network(
                    "https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    width: double.infinity,
                    height: coverHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: topPosition,
                  left: 10,
                  child: CircleAvatar(
                    radius: profileHeight / 2,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: NetworkImage(
                        "https://lh4.googleusercontent.com/-SB4Q8oQcM9I/AAAAAAAAAAI/AAAAAAAAAAA/RgtXudsGnT0/c-rp-mo-br100/photo.jpg"),
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
