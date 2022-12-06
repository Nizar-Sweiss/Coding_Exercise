import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:userprofile/models/user.dart';
import 'package:userprofile/utility/firebase/storage_service.dart';
import 'package:userprofile/utility/utility_barrel.dart';
import 'package:userprofile/widgets/widgets_barrel.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:csc_picker/csc_picker.dart';

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
  //Determining The images heights.
  final double coverHeight = 150;
  final double profileHeight = 150;

  final Stream<QuerySnapshot> users = userCollection.snapshots();

  String userDocID = "TqrALtHASBtcgstKLGUx";
  //Text Form Field controllers.
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  //State Form Key to track the state of the forms (valid or not).
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //provide controllers data of the user information from firebase store for accessibility
    displayNameController.text = widget.userData.displayName;
    firstNameController.text = widget.userData.firstName;
    lastNameController.text = widget.userData.lastName;
    emailController.text = widget.userData.email;
    ageController.text = widget.userData.age;
    countryController.text = widget.userData.country;
    cityController.text = widget.userData.city;
    majorController.text = widget.userData.major;
    stateController.text = widget.userData.state;

    super.initState();
  }

  @override
  void dispose() {
    //dispoing controllers when widget is removed permanently from the widget tree
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
      floatingActionButton: conformFloatingButton(context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editInfo),
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
                      return const Text("Something went Wrong :\"");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading ...");
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _TextFields(context),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton conformFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final isValidForm = formKey.currentState!.validate();
        if (isValidForm) {
          final userDoc = userCollection.doc(userDocID);

          // Handles the user data and updates it in firebase store
          updateUserData(userDoc);
          //SnackBar alert
          Utils.showSnackBar("Updated Successfuly", false);
          Navigator.pop(context);
        } else {
          Utils.showSnackBar("Check Your Information", true);
        }
      },
      child: const Icon(Icons.done),
    );
  }

  void updateUserData(DocumentReference<Map<String, dynamic>> docUser) {
    docUser.update({
      'age': ageController.text.trim(),
      'city': cityController.text,
      'country': countryController.text,
      'display name': displayNameController.text.trim(),
      'email': emailController.text.trim(),
      'first name': firstNameController.text.trim(),
      'last name ': lastNameController.text.trim(),
      'cover image': widget.userData.coverImagePath,
      'profile image': widget.userData.profileImagePath,
      'state': stateController.text,
      'major': majorController.text
    });
  }

  List<Widget> _TextFields(BuildContext context) {
    return [
      _FirstNameField(context),
      _LastNameField(context),
      _DisplayNameField(context),
      _MAjorField(context),
      _EmailField(context),
      _AgeField(context),
      _CountryInfoField(context),
    ];
  }

  DefaultFormField _MAjorField(BuildContext context) {
    return DefaultFormField(
        validator: (text) {
          if (text!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(text)) {
            return AppLocalizations.of(context)!.majorError;
          }
        },
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.major,
        controller: majorController);
  }

  CSCPicker _CountryInfoField(BuildContext context) {
    return CSCPicker(
      cityDropdownLabel: AppLocalizations.of(context)!.city,
      countryDropdownLabel: AppLocalizations.of(context)!.country,
      stateDropdownLabel: AppLocalizations.of(context)!.state,
      dropdownDialogRadius: 20,
      searchBarRadius: 20,
      currentCountry: countryController.text,
      currentCity: cityController.text,
      currentState: stateController.text,
      layout: Layout.vertical,
      dropdownHeadingStyle: TextStyle(color: Colors.white),
      dropdownItemStyle: TextStyle(color: Colors.white),
      onCityChanged: (city) {
        if (city == null) {
          cityController.text = "-";
        } else {
          cityController.text = city;
        }
      },
      onStateChanged: (state) {
        if (state == null) {
          stateController.text = "-";
        } else {
          stateController.text = state;
        }
      },
      onCountryChanged: (country) {
        countryController.text = country;
      },
    );
  }

  DefaultFormField _AgeField(BuildContext context) {
    return DefaultFormField(
        validator: (text) {
          if (text!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(text)) {
            return AppLocalizations.of(context)!.ageError;
          }
        },
        keyboardtype: TextInputType.number,
        maxLength: 2,
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.age,
        controller: ageController);
  }

  DefaultFormField _EmailField(BuildContext context) {
    return DefaultFormField(
        validator: (email) => email!.isEmpty && !EmailValidator.validate(email)
            ? AppLocalizations.of(context)!.emailError
            : null,
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.email,
        keyboardtype: TextInputType.emailAddress,
        controller: emailController);
  }

  DefaultFormField _DisplayNameField(BuildContext context) {
    return DefaultFormField(
        validator: (text) {
          if (text!.isEmpty || !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(text)) {
            return AppLocalizations.of(context)!.displayNameError;
          }
        },
        keyboardtype: TextInputType.name,
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.displayName,
        controller: displayNameController);
  }

  DefaultFormField _LastNameField(BuildContext context) {
    return DefaultFormField(
        validator: (text) {
          if (text!.isEmpty || !RegExp(r'^[a-z A-Z ]+$').hasMatch(text)) {
            return AppLocalizations.of(context)!.lastNameError;
          }
        },
        keyboardtype: TextInputType.name,
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.lastName,
        controller: lastNameController);
  }

  DefaultFormField _FirstNameField(BuildContext context) {
    return DefaultFormField(
        validator: (text) {
          if (text!.isEmpty || !RegExp(r'^[a-z A-Z ]+$').hasMatch(text)) {
            return AppLocalizations.of(context)!.firstNameError;
          }
        },
        keyboardtype: TextInputType.name,
        hint: "Enter here ... ",
        title: AppLocalizations.of(context)!.firstName,
        controller: firstNameController);
  }

  //returns the Over lap of CoverImage and ProfileImage on top of the screen
  Widget buildTopContents(String coverImage, String profileImage) {
    final Storage storage = Storage();
    //to position the profile image between the cover image and the contents info
    final topPosition = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CoverImage(
          coverImage: coverImage,
        ),
        Positioned(
          right: 1,
          top: topPosition,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: IconButton(
                onPressed: () async {
                  //A package that allows you to use the native file explorer to pick single or multiple files,
                  // with extensions filtering support['png', 'jpg'].
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
                        return;
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
                      color: Color.fromARGB(255, 254, 254, 254),
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
