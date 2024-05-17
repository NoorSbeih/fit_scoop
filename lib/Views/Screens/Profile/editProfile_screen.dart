import 'dart:typed_data';

import 'package:fit_scoop/Controllers/user_controller.dart';

import 'package:fit_scoop/Views/Screens/Profile/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Models/user_model.dart';

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
    bioController.text = widget.user.bio!;
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    String? imageUrl = widget.user.imageLink;
    setState(() {
      this.imageUrl = imageUrl;
    });
  }

  void saveProfile() async {
    UserController controller = UserController();
    controller.updateProfileImage(image!, widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
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
                                color: Color(
                                    0xFF0dbab4), // Set the color if needed
                              ),
                            ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: SvgPicture.asset(
                        'images/write-svgrepo-com.svg',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(height: 30.0),
            const Text(
              'USERNAME',
              style: TextStyle(
                  color: Color(0xFF0dbab4),
                  fontSize: 20,
                  fontFamily: 'BebasNeue'),
            ),
            TextField(
              controller: controller,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'GENDER',
              style: TextStyle(
                  color: Color(0xFF0dbab4),
                  fontSize: 20,
                  fontFamily: 'BebasNeue'),
            ),
            TextField(
              controller: controller,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'BebasNeue'),
            ),
            SizedBox(height: 20.0),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProfile,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF0dbab4)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(335, 50)),
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
    );
  }
}
