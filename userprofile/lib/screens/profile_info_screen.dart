import 'package:flutter/material.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';

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
          buildTopContents(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "NAME",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const Text(
                "Specialty",
                style: TextStyle(fontSize: 20),
              ),
              const Divider(
                thickness: 1,
              ),
              DefaultTextBox(text: "FNAME ", title: "First Name "),
              DefaultTextBox(text: "LNAME ", title: "Last Name "),
              DefaultTextBox(text: "23", title: "Age"),
              DefaultTextBox(text: "Email@Email.com", title: "Email"),
              DefaultTextBox(text: "Jordan", title: "Country"),
              DefaultTextBox(text: "City", title: "City"),
            ]),
          )
        ],
      )),
    );
  }

//returns the Over lap of CoverImage and ProfileImage on the top of the screen
  Widget buildTopContents() {
    final topPosition = coverHeight -
        profileHeight /
            2; //to position the profile image between the cover image and the contents info
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: topPosition, left: 10, child: buildProfileImage()),
      ],
    );
  }

// display the background cover picture
  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          "https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
// display the profile picture
  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.blueGrey,
      );
}
