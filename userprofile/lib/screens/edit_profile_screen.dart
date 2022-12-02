import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/utility/firebase_service.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _nameState();
}

class _nameState extends State<EditProfileScreen> {
  final double coverHeight = 280;

  final double profileHeight = 150;
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("users").snapshots();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30,
        child: IconButton(
          icon: Icon(
            Icons.done,
            size: 30,
          ),
          onPressed: () {},
        ),
      ),
      appBar: AppBar(
        title: const Text("Edit Info"),
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "First Name",
                          controller: firstNameController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "Last Name",
                          controller: lastNameController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "Display Name",
                          controller: displayNameController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "Email",
                          controller: emailController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "Age",
                          controller: ageController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "Country",
                          controller: countryController),
                      DefaultFormField(
                          hint: "Enter here ... ",
                          title: "City",
                          controller: cityController),
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
        Container(
            color: const Color.fromARGB(255, 80, 80, 80),
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage()),
        Positioned(
            top: topPosition,
            left: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 75,
              child: Stack(
                children: [
                  buildProfileImage(),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color.fromARGB(255, 0, 117, 207),
                          size: 40,
                        )),
                  ),
                ],
              ),
            )),
        Positioned(
          right: 1,
          top: topPosition + 20,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 40,
              )),
        ),
      ],
    );
  }

// display the background cover picture
  Widget buildCoverImage() => FutureBuilder(
        future: _getImage(context, "bk1.jpg"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
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
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 1.2,
              child: snapshot.data,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 1.2,
              child: const Center(child: CircularProgressIndicator()),
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
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }
}
