import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/utility/firebase/storage_service.dart';
import 'package:userprofile/utility/utility_barrel.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class EditProfileScreen extends StatefulWidget {
  final User userData;

  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  final double coverHeight = 150;
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

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    displayNameController.text = widget.userData.displayName;
    firstNameController.text = widget.userData.firstName;
    lastNameController.text = widget.userData.lastName;
    emailController.text = widget.userData.email;
    ageController.text = widget.userData.age;
    countryController.text = widget.userData.country;
    cityController.text = widget.userData.city;
    super.initState();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    countryController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final isValidForm = formKey.currentState!.validate();
          if (isValidForm) {
            final docUser = FirebaseFirestore.instance
                .collection("users")
                .doc("TqrALtHASBtcgstKLGUx");

            //update user fields
            docUser.update({
              'age': ageController.text.trim(),
              'city': cityController.text.trim(),
              'country': countryController.text.trim(),
              'display name': displayNameController.text.trim(),
              'email': emailController.text.trim(),
              'first name': firstNameController.text.trim(),
              'last name ': lastNameController.text.trim(),
              'cover image': widget.userData.coverImagePath,
              'profile image': widget.userData.profileImagePath
            });
            Utils.showSnackBar("Updated Successfuly", false);
            Navigator.pop(context);
          } else {
            Utils.showSnackBar("Check Your Information", true);
          }
        },
        child: const Icon(
          Icons.done,
        ),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editInfo),
        //title postion in the middle of the App Bar
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: ListView(
          children: [
            buildTopContents(widget.userData.coverImagePath,
                widget.userData.profileImagePath),
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
                            validator: (text) {
                              if (text!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .firstNameError;
                              }
                            },
                            keyboardtype: TextInputType.name,
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.firstName,
                            controller: firstNameController),
                        DefaultFormField(
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z ]+$').hasMatch(text)) {
                                return AppLocalizations.of(context)!
                                    .displayNameError;
                              } else {
                                return null;
                              }
                            },
                            keyboardtype: TextInputType.name,
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.lastName,
                            controller: lastNameController),
                        DefaultFormField(
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(text)) {
                                return AppLocalizations.of(context)!
                                    .displayNameError;
                              } else {
                                return null;
                              }
                            },
                            keyboardtype: TextInputType.name,
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.displayName,
                            controller: displayNameController),
                        DefaultFormField(
                            validator: (email) => email!.isEmpty &&
                                    !EmailValidator.validate(email)
                                ? AppLocalizations.of(context)!.emailError
                                : null,
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.email,
                            keyboardtype: TextInputType.emailAddress,
                            controller: emailController),
                        DefaultFormField(
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !RegExp(r'^[0-9]+$').hasMatch(text)) {
                                return AppLocalizations.of(context)!.ageError;
                              } else {
                                return null;
                              }
                            },
                            keyboardtype: TextInputType.number,
                            maxLength: 2,
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.age,
                            controller: ageController),
                        DefaultFormField(
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(text)) {
                                return AppLocalizations.of(context)!
                                    .countryError;
                              } else {
                                return null;
                              }
                            },
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.country,
                            controller: countryController),
                        DefaultFormField(
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(text)) {
                                return AppLocalizations.of(context)!.cityError;
                              } else {
                                return null;
                              }
                            },
                            hint: "Enter here ... ",
                            title: AppLocalizations.of(context)!.city,
                            controller: cityController),
                      ],
                    );
                  },
                ))
          ],
        ),
      )),
    );
  }

//returns the Over lap of CoverImage and ProfileImage on the top of the screen
  Widget buildTopContents(String coverImage, String profileImage) {
    final Storage storage = Storage();

    final topPosition = coverHeight -
        profileHeight /
            2; //to position the profile image between the cover image and the contents info
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CoverImage(
          coverImage: coverImage,
          isEdit: true,
        ),
        Positioned(
          right: 1,
          top: topPosition,
          child: CircleAvatar(
            radius: 30,
            child: IconButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg']);
                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No file selected ")));
                    return null;
                  }
                  setState(() {
                    final path = result.files.single.path!;
                    final fileName = result.files.single.name;
                    widget.userData.coverImagePath = fileName;
                    storage
                        .uploadFile(path, fileName)
                        .then((value) => print("uploaded successfuly"));
                    Utils.showSnackBar(
                        "Cover Image set seccessfully.\nconform your edit to make change ",
                        false);
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                )),
          ),
        ),
        Positioned(
          top: topPosition,
          left: 10,
          child: Stack(
            children: [
              ProfileImage(
                profileImage: profileImage,
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: IconButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg']);
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No file selected ")));
                        return null;
                      }
                      setState(() {
                        final path = result.files.single.path!;
                        final fileName = result.files.single.name;
                        widget.userData.profileImagePath = fileName;
                        storage
                            .uploadFile(path, fileName)
                            .then((value) => print("uploaded successfuly"));
                        Utils.showSnackBar(
                            "Profile Image set seccessfully.\nconform your edit to make change ",
                            false);
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color.fromARGB(255, 0, 117, 207),
                      size: 40,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
