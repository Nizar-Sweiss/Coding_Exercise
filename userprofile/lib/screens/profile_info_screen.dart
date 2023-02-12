import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/utility/firebase/firebase_service.dart';
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
  final Stream<QuerySnapshot> users = userCollection.snapshots();
  late QuerySnapshot<Object?> data;
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileInfo),
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

            data = snapshot.requireData;
            user = fetchLocalUser();

            return ListView(
              children: [
                _topScreenWidgets(),
                _paddedUserInfo(),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _paddedUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: userInfo(),
    );
  }

  // returns a User Object of the fetched data from firebase to make local Object
  User fetchLocalUser() {
    return User(
        firstName: "${data.docs[0]["first name"]}",
        email: "${data.docs[0]["email"]}",
        lastName: "${data.docs[0]["last name "]}",
        displayName: " ${data.docs[0]["display name"]}",
        age: data.docs[0]["age"],
        country: "${data.docs[0]["country"]}",
        city: "${data.docs[0]["city"]}",
        major: "${data.docs[0]["major"]}",
        coverImagePath: "${data.docs[0]["cover image"]}",
        profileImagePath: "${data.docs[0]["profile image"]}",
        state: "${data.docs[0]["state"]}");
  }

  // returns the Over lap of CoverImage, ProfileImage
  // and EditUserInfo_Icon on the top of the screen
  Widget _topScreenWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _coverImage(),
            _positionedEditUserInfoIcon(),
            _positionedProfileImage(),
          ],
        ),
        userHeadLine(),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }

  CoverImage _coverImage() {
    return CoverImage(
      coverImage: user.coverImagePath,
    );
  }

  Positioned _positionedProfileImage() {
    // to position the profile image between
    // the cover image and the contents info
    final double topPosition = coverHeight - profileHeight / 2;

    return Positioned(
      top: topPosition,
      left: 10,
      child: _profileImage(),
    );
  }

  ProfileImage _profileImage() {
    return ProfileImage(
      profileImage: user.profileImagePath,
    );
  }

  Positioned _positionedEditUserInfoIcon() {
    return Positioned(
      right: 1,
      bottom: 1,
      child: _editUserInfoIcon(),
    );
  }

  IconButton _editUserInfoIcon() {
    return IconButton(
      style: IconButton.styleFrom(),
      icon: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () {
        navigateToEditProfileScreen();
      },
    );
  }

  void navigateToEditProfileScreen() {
    Navigator.pushNamed(
      context,
      "/editProfile",
      arguments: user,
    );
  }

  /// User Head Line information (Display name and Major).
  userHeadLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userNickNameHeadLine(),
        _userMajorHeadLine(),
      ],
    );
  }

  Text _userMajorHeadLine() {
    return Text(
      user.major,
      style: Theme.of(context).textTheme.headline2,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _userNickNameHeadLine() {
    return Text(
      user.displayName,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  // returns column of the user information from firebase in a text Box
  Column userInfo() {
    return Column(
      children: [
        _firstNameTextBox(),
        _lastNameTextBox(),
        _ageTextBox(),
        _emailTextBox(),
        _countryTextBox(),
        _stateTextBox(),
      ],
    );
  }

  DefaultTextBox _stateTextBox() {
    return DefaultTextBox(
        text: " ${user.state} - ${user.city}",
        title: AppLocalizations.of(context)!.state);
  }

  DefaultTextBox _countryTextBox() {
    return DefaultTextBox(
        text: user.country, title: AppLocalizations.of(context)!.country);
  }

  DefaultTextBox _emailTextBox() {
    return DefaultTextBox(
        text: user.email, title: AppLocalizations.of(context)!.email);
  }

  DefaultTextBox _ageTextBox() {
    return DefaultTextBox(
        text: user.age.toString(), title: AppLocalizations.of(context)!.age);
  }

  DefaultTextBox _lastNameTextBox() {
    return DefaultTextBox(
        text: user.lastName, title: AppLocalizations.of(context)!.lastName);
  }

  DefaultTextBox _firstNameTextBox() {
    return DefaultTextBox(
        text: user.firstName, title: AppLocalizations.of(context)!.firstName);
  }
}
