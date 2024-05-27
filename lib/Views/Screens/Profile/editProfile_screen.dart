import 'dart:typed_data';

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
  String? gender;
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

    getGender().then((_) {
      initialGender = gender;
    });
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


  Future<void> getGender() async {
    if (widget.user?.bodyMetrics != null) {
      BodyMetricsController controller = BodyMetricsController();
      bodyMetrics = await controller.fetchBodyMetrics(widget.user!.bodyMetrics);
      setState(() {
        gender = bodyMetrics?.gender;
      });
    } else {
      print("User's bodyMetrics ID is null");
    }
  }


  void saveProfile() async {
    UserController controller = UserController();
    BodyMetricsController controller2 = BodyMetricsController();

    bool isNameChanged = initialName != this.controller.text;
    bool isBioChanged = initialBio != bioController.text;
    bool isGenderChanged = initialGender != gender;
    bool isImageChanged = image != null;

    if (isNameChanged) {
      print("kkk");
      widget.user.name = this.controller.text;
      await controller.updateProfile(widget.user);
      hasChanges = true;
    }
    if (isBioChanged) {
      print("kkk1");
      widget.user.bio = bioController.text;
      await controller.updateProfile(widget.user);
      hasChanges = true;
    }
    if (isGenderChanged) {
      print("kkk2");
      if (widget.user.bodyMetrics != null) {
        if (bodyMetrics != null) {
          bodyMetrics?.gender = gender!;
          String? x = widget.user.bodyMetrics;
          await controller2.updateBodyMetrics(x!, bodyMetrics!);
          hasChanges = true;
        } else {
          // Handle the case where bodyMetrics is null
          print("bodyMetrics is null, cannot update gender");
        }
      } else {
        // Handle the case where user's bodyMetrics ID is null
        print("User's bodyMetrics ID is null, cannot update gender");
      }
    }

    if (isImageChanged) {
      print("kkk3");
      await controller.updateProfileImage(image!, widget.user.id);
      hasChanges = true;
    }

    if (isNameChanged || isGenderChanged || isBioChanged || isImageChanged) {
      showAlertDialog('Profile updated successfully', Colors.green);
      hasChanges = false;
      initialName = this.controller.text;
      initialBio = bioController.text;
      initialGender = gender;
      initialImageUrl = widget.user.imageLink;
    } else {
      showAlertDialog('No changes detected', Colors.grey);
    }
  }

  Future<bool> showDiscardChangesDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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

  void showAlertDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
        child: AlertDialog(
          backgroundColor: color,
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
                Navigator.pop(context);
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
    bool isGenderChanged = initialGender != gender;
    bool isImageChanged = image != null;
    bool hasChanges = isNameChanged || isBioChanged || isGenderChanged || isImageChanged;
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
                  const Text(
                    'GENDER',
                    style: TextStyle(
                        color: Color(0xFF0dbab4),
                        fontSize: 30,
                        fontFamily: 'BebasNeue'),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        activeColor: Color(0xFF0dbab4),
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'BebasNeue',
                            fontSize: 20),
                      ),
                      Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        activeColor: Color(0xFF0dbab4),
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'BebasNeue',
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                    'BIO',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF0dbab4),
                        fontFamily: 'BebasNeue'),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
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
                          style: TextStyle(fontSize: 15, color: Colors.white),
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
                      'Save changes',
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
