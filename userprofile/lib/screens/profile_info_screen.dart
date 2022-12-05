import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreen();
}

class _ProfileInfoScreen extends State<ProfileInfoScreen> {
  final double coverHeight = 150;
  final double profileHeight = 150;

  final String userID = "TqrALtHASBtcgstKLGUx";

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection("users").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileInfo),
        //title postion in the middle of the App Bar
        centerTitle: true,
      ),
      body: SafeArea(
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
          final user = fitchLocalUser(data);

          return ListView(
            children: [
              buildTopContents(user.profileImagePath, user.coverImagePath),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
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
                          style: IconButton.styleFrom(),
                          icon: const Icon(
                            Icons.edit,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/editProfile",
                              arguments: user,
                            );
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
                        text: user.firstName,
                        title: AppLocalizations.of(context)!.firstName),
                    DefaultTextBox(
                        text: user.lastName,
                        title: AppLocalizations.of(context)!.lastName),
                    DefaultTextBox(
                        text: user.age,
                        title: AppLocalizations.of(context)!.age),
                    DefaultTextBox(
                        text: user.email,
                        title: AppLocalizations.of(context)!.email),
                    DefaultTextBox(
                        text: user.country,
                        title: AppLocalizations.of(context)!.country),
                    DefaultTextBox(
                        text: user.city,
                        title: AppLocalizations.of(context)!.city),
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }

  User fitchLocalUser(QuerySnapshot<Object?> data) {
    return User(
        firstName: "${data.docs[0]["first name"]}",
        email: "${data.docs[0]["email"]}",
        lastName: "${data.docs[0]["last name "]}",
        displayName: " ${data.docs[0]["display name"]}",
        age: "${data.docs[0]["age"]}",
        country: "${data.docs[0]["country"]}",
        city: "${data.docs[0]["city"]}",
        major: "${data.docs[0]["major"]}",
        coverImagePath: "${data.docs[0]["cover image"]}",
        profileImagePath: "${data.docs[0]["profile image"]}");
  }

//returns the Over lap of CoverImage and ProfileImage on the top of the screen
  Widget buildTopContents(String profileImage, String coverImage) {
    final topPosition = coverHeight -
        profileHeight /
            2; //to position the profile image between the cover image and the contents info
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CoverImage(
          coverImage: coverImage,
        ),
        Positioned(
          top: topPosition,
          left: 10,
          child: ProfileImage(
            profileImage: profileImage,
          ),
        ),
      ],
    );
  }
}
