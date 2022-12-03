import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/utility/firebase_service.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreen();
}

class _ProfileInfoScreen extends State<ProfileInfoScreen> {
  final double coverHeight = 150;

  final double profileHeight = 150;
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("users").snapshots();
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
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Something went Wrong ");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading ...");
                  }
                  final data = snapshot.requireData;
                  final user = User(
                      firstName: "${data.docs[0]["first name"]}",
                      email: "${data.docs[0]["email"]}",
                      lastName: "${data.docs[0]["last name "]}",
                      displayName: " ${data.docs[0]["display name"]}",
                      age: "${data.docs[0]["age"]}",
                      country: "${data.docs[0]["country"]}",
                      city: "${data.docs[0]["city"]}",
                      major: "${data.docs[0]["major"]}");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${user.displayName}",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/editProfile");
                            },
                          ),
                        ],
                      ),
                      Text(
                        user.major,
                        style: Theme.of(context).textTheme.headline2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      DefaultTextBox(
                          text: user.firstName, title: "First Name "),
                      DefaultTextBox(text: user.lastName, title: "Last Name "),
                      DefaultTextBox(text: user.age, title: "Age"),
                      DefaultTextBox(text: user.email, title: "Email"),
                      DefaultTextBox(text: user.country, title: "Country"),
                      DefaultTextBox(text: user.city, title: "City"),
                    ],
                  );
                },
              ))
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
        buildCoverImage(),
        Positioned(
          top: topPosition,
          left: 10,
          child: buildProfileImage(),
        ),
      ],
    );
  }

// display the background cover picture
  Widget buildCoverImage() => FutureBuilder(
        future: _getImage(context, "bk1.jpg"),
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
      );
// display the profile picture
  Widget buildProfileImage() => FutureBuilder(
        future: _getImage(context, "pfp1.png"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(100)
                  //more than 50% of width makes circle
                  ),
              height: profileHeight,
              width: profileHeight,
              child: snapshot.data,
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
  //return requested image from FireStorage
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
