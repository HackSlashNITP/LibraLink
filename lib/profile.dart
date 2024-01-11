import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:libralink/routes/mapping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  String idCardImageUrl = '';
  String profilepicUrl='';
  bool editMode=false;
  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      print("User signed out");
      Navigator.pushNamed(context, MyRoutes.signinRoute);
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
  File? _image;
  @override
  void initState(){
    super.initState();
    _loadUserData();
  }
  File? idCardImage;
  Future<void> _loadUserData() async{
    try{
      User? user = _auth.currentUser;
      if(user!=null){
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
        if(userData.exists){
          setState(() {
            fullNameController.text=userData['name']??'';
            usernameController.text=userData['username']??'';
            contactNumberController.text=userData['contact']??'';
            emailAddressController.text=userData['email']??'';
            idCardImageUrl=userData['Id']??'';
            profilepicUrl=userData['Profile']??'';

          });
        }
      }
    }catch(e){
      print('error');
    }
  }
  Future<void> saveUserData() async {
    try {
      User? user= FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
        'name': fullNameController.text,
        'username': usernameController.text,
        'contact': contactNumberController.text,
        'email': emailAddressController.text,
        //'password': passwordController.text,
        'Id': idCardImageUrl,
        'uid': user?.uid,
        'Profile':profilepicUrl,

      });
    } catch (e) {
      print('Error saving data: $e');
    }
  }
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
        final image =
        await imagePicker.pickImage(source: ImageSource.gallery);
        if (image != null) {
        try {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');

        final UploadTask uploadTask = storageReference.putFile(
        File(image.path));
        final TaskSnapshot taskSnapshot = await uploadTask;

        final String downloadURL = await taskSnapshot.ref.getDownloadURL();

        setState(() {
        idCardImage = File(image.path);
        profilepicUrl = downloadURL;
        });
        } catch (e) {
        print('Error uploading profile image: $e');
        }
        }
        }
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () async {
    Navigator.pop(context);
    final image =
    await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
    try {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');

    final UploadTask uploadTask = storageReference.putFile(
    File(image.path));
    final TaskSnapshot taskSnapshot = await uploadTask;

    final String downloadURL = await taskSnapshot.ref.getDownloadURL();

    setState(() {
    idCardImage = File(image.path);
    profilepicUrl = downloadURL;
    });
    } catch (e) {
    print('Error uploading profile image: $e');
    }
    }
    }
    ),
                  ]);
      },
    );
  }

  Future<void> _pickIdCardImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('id_card_images')
            .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');

        final UploadTask uploadTask = storageReference.putFile(
            File(pickedFile.path));
        final TaskSnapshot taskSnapshot = await uploadTask;

        final String downloadURL = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          idCardImage = File(pickedFile.path);
          idCardImageUrl = downloadURL;
        });
      } catch (e) {
        print('Error uploading ID card image: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              editMode=!editMode;
            });
          }, icon: Icon(
            Icons.edit,color: Colors.black,
          )),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ),
            onPressed: _signOut,
          )
        ],
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
                      onTap: editMode? _pickImage:null,
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
                              :(profilepicUrl.isNotEmpty)?Image.network(profilepicUrl,fit: BoxFit.cover,)
                                  : Image.asset(
                                      'assets/avatar.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          if (_image == null&&editMode)
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
                            child: Image.file(idCardImage!,fit:BoxFit.cover)
                          )
                        else if(idCardImageUrl.isNotEmpty)
                         Container(
                         width: 150,
                         height: 100,
    child:Image.network(idCardImageUrl,fit: BoxFit.cover,)
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
              onPressed: editMode?saveUserData:null,
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
