import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();

  File? _image;
  File? idCardImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await showModalBottomSheet<PickedFile>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                  final image =  await imagePicker.pickImage(source: ImageSource.gallery);
                 if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                 final image=  await imagePicker.pickImage(source: ImageSource.camera);
               if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
              },
            ),
          ],
        );
      },
    );

  }

  Future<void> _pickIdCardImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        idCardImage = File(pickedFile.path);
        idCardController.text =
            pickedFile.path; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'PROFILE',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: _image != null
                                  ? AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/avatar.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          if(_image == null)
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: Image.asset(
                                  'assets/plus.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  // Full Name
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                  SizedBox(height: 10),

                  // Username
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  SizedBox(height: 10),

                  // Contact Number
                  TextField(
                    controller: contactNumberController,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      suffixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Email Address
                  TextField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'email.nitp.ac.in',
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Password
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.password_outlined),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: idCardController,
                    decoration: InputDecoration(
                      labelText: 'ID Card',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          
                          _pickIdCardImage();
                        },
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                    
                      if (idCardImage != null) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Image.file(idCardImage!),
                            );
                          },
                        );
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (idCardImage != null)
                          Container(
                            width: 150, 
                            height: 100, 
                            child: Image.file(idCardImage!, fit: BoxFit.cover),
                          )
                        else
                          Text(
                            'Click on Icon to Upload ID',
                            style: TextStyle(fontSize: 15),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),

            // Save Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(150, 40),
              ),
              child: Text('Save',
                  style: TextStyle(color: Colors.white, fontSize: 15.0)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    contactNumberController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    idCardController.dispose();
    super.dispose();
  }
}
