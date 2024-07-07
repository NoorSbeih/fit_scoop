import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:fit_scoop/Views/Screens/Profile/profile_screen.dart';

import 'package:fit_scoop/Views/Screens/Profile/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controllers/body_metrics_controller.dart';
import '../../../Models/body_metrics_model.dart';
import '../../../Models/user_model.dart';
import '../main_page_screen.dart';

class EditProfile extends StatefulWidget {
  final User_model user;

  const EditProfile({super.key, required this.user});

  @override
  createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  TextEditingController controller = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List? image;
  String? imageUrl;
  BodyMetrics? bodyMetrics;
  late String initialName;
  late String initialBio;
  late String? initialGender;
  late String? initialImageUrl;
  bool hasChanges = false;
  bool nav=false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.user.name;
    bioController.text = widget.user.bio ?? '';
    getImageUrl();
    initialName = widget.user.name;
    initialBio = widget.user.bio ?? '';
    initialImageUrl = widget.user.imageLink;
  }

  Future<void> getImageUrl() async {
    String? imageUrl = widget.user.imageLink;
    setState(() {
      this.imageUrl = imageUrl;
    });
  }
  Future<String> uploadImageToStorage(Uint8List image) async {
    String userId = widget.user.id; // Use the user's ID or any unique identifier
    Reference ref = FirebaseStorage.instance.ref().child('userImages').child(userId);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }



  void saveProfile() async {
    UserController controller = UserController();
    bool isNameChanged = initialName != this.controller.text;
    bool isBioChanged = initialBio != bioController.text;
    bool isImageChanged = image != null;

    if (isNameChanged) {
      widget.user.name = this.controller.text;
      await controller.updateProfile(widget.user);
      hasChanges = true;
    }
    if (isBioChanged) {
      widget.user.bio = bioController.text;
      await controller.updateProfile(widget.user);
      hasChanges = true;
    }


    if (isImageChanged) {
      String imageUrl = await uploadImageToStorage(image!);
      widget.user.imageLink = imageUrl;
      await controller.updateProfileImage(image!, widget.user.id);
      hasChanges = true;
    }


    if (isNameChanged || isBioChanged || isImageChanged) {
      showAlertDialog('Profile updated successfully');
      hasChanges = false;
      initialName = this.controller.text;
      initialBio = bioController.text;
      initialImageUrl = widget.user.imageLink;
    } else {
      showAlertDialog('No changes detected');
    }
  }

  Future<bool> showDiscardChangesDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2C2A2A),
          title: Text('Discard changes?'),
          content: Text('You have unsaved changes. Do you really want to discard them?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Discard'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false; // In case the dialog is dismissed by other means (e.g., back button)
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
        child: AlertDialog(
          backgroundColor: Color(0xFF2C2A2A),
          title: const Text(
            'Profile Update',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomePage(initialIndex: 4)),
              // Set initialIndex to 1 for ProfilePage
                  (Route<dynamic> route) => false,
            );
          },

            ),
          ],
        ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    bool isNameChanged = initialName != this.controller.text;
    bool isBioChanged = initialBio != bioController.text;
    bool isImageChanged = image != null;
    bool hasChanges = isNameChanged || isBioChanged  || isImageChanged;
    if (hasChanges) {
      bool discard = await showDiscardChangesDialog(context);
      return discard;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFF2C2A2A),
          appBar: AppBar(
            backgroundColor: Color(0xFF2C2A2A),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 25, // Adjust the font size as needed
                fontFamily: 'BebasNeue',
                color: Colors.white, // Adjust the color as needed
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Color(0xFF0dbab4)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                            : imageUrl != null
                            ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(imageUrl!),
                        )
                            : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'images/profile-circle-svgrepo-com.svg',
                            width:
                            128, // Adjust the width and height as needed
                            height: 128,
                            color: const Color(
                                0xFF0dbab4), // Set the color if needed
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 90,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: SvgPicture.asset(
                              'images/write-svgrepo-com.svg',
                              width: 24,
                              height: 24,
                              color: Color(0xFF0dbab4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'USERNAME',
                    style: TextStyle(
                        color: Color(0xFF0dbab4),
                        fontSize: 30,
                        fontFamily: 'BebasNeue'),
                  ),
                  TextField(
                    controller: controller,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'BebasNeue'),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  const Text(
                    'BIO',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF0dbab4),
                        fontFamily: 'BebasNeue'),
                  ),
                  Container(
                    height: 300,
                    width:380,
                    padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: bioController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveProfile,
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(335, 50)),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    child: const Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF2C2A2A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        );

}
}
