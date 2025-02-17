import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:terracred/bottom-sheet/insta_share_bottom_sheet.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/db/shared_pref.dart';
import 'package:terracred/multi-language/classes/language_constants.dart';
import 'package:terracred/navigators.dart';
import 'package:terracred/widgets/home/bottom-bar/profile_delete.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class WifeProfileScreen extends StatefulWidget {
  const WifeProfileScreen({super.key});

  @override
  _WifeProfileScreenState createState() => _WifeProfileScreenState();
}

class _WifeProfileScreenState extends State<WifeProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weekController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _totalWeekController = TextEditingController();
  String? profilePic = wifeProfileDefault;
  String? _initialWeek;
  final User? user = FirebaseAuth.instance.currentUser;
  File? newProfilePic;
  bool isSaving = false;
  String? totalWeeks = '36';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('backend').doc('terracred').collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _nameController.text = userData['name'];
        _weekController.text = userData['week'];
        _bioController.text = userData['bio'];
        _totalWeekController.text = userData['totalWeek'];

        profilePic = userData['profilePic'];
        _initialWeek = userData['week'];
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weekController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
            onPressed: () => goBack(context)),
        title: Text(
          translation(context).profile,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              checkWeekUpdate();
              _updateProfile();
            },
            child: Text(
              translation(context).save,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       showModalBottomSheet<void>(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return InstaShareBottomSheet();
      //         },
      //       );
      //     },
      //     backgroundColor: Colors.red,
      //     foregroundColor: boxColor,
      //     highlightElevation: 50,
      //     child: Icon(
      //       Icons.warning_outlined,
      //     ),
      //   ),
      // ),
      body: isSaving
          ? progressIndicator(context)
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildProfileHeader(),
                  _buildDeleteAccountButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              await _pickImage();
            },
            child: newProfilePic != null
                ? CircleAvatar(
                    backgroundImage: FileImage(newProfilePic!),
                    radius: 60,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(profilePic!),
                    radius: 60,
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: translation(context).name),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _bioController,
                  decoration:
                      InputDecoration(labelText: translation(context).bio),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        newProfilePic = File(res.files.first.path!);
      });
    }
  }

  Widget _buildPregnancyTracker() {
    int userWeek = int.tryParse(_weekController.text) ?? 0;
    int totalWeeks = int.tryParse(_totalWeekController.text) ?? 0;

    double progressValue = totalWeeks > 0 ? userWeek / totalWeeks : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(translation(context).pregnancyTracker,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
          const SizedBox(height: 10),
          Text("${translation(context).week} $userWeek of $totalWeeks",
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildHealthSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(translation(context).healthTips,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(translation(context).dailyExercise),
            subtitle: Text(translation(context).aboutDailyExercise),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(translation(context).balancedDiet),
            subtitle: Text(translation(context).aboutBalancedDiet),
          ),
        ],
      ),
    );
  }

  checkWeekUpdate() async {
    if (_initialWeek != _weekController.text) {
      DateTime now = DateTime.now();
      var current_year = now.year;
      var current_mon = now.month;
      var current_day = now.day;

      await FirebaseFirestore.instance
          .collection('backend').doc('terracred').collection('users')
          .doc(user!.uid)
          .update({
        'weekUpdatedDay': current_day,
        'weekUpdatedMonth': current_mon,
        'weekUpdatedYear': current_year,
        'weekUpdated': _weekController.text,
      });
    }
  }

  Future<void> _updateProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      setState(() {
        isSaving = true;
      });

      // Update profile picture if it's changed
      String? downloadUrl;
      if (newProfilePic != null) {
        print(newProfilePic);
        downloadUrl = await _uploadImage(newProfilePic!);
      }

      // Update other profile information
      await FirebaseFirestore.instance
          .collection('backend').doc('terracred').collection('users')
          .doc(user!.uid)
          .update({
        'name': _nameController.text,
        'week': _weekController.text,
        'bio': _bioController.text,
        'totalWeek': _totalWeekController.text,
        if (downloadUrl != null)
          'profilePic': downloadUrl
        else
          'profilePic': profilePic,
      });

      dialogueBoxWithButton(
          context, translation(context).diologueUpdateProfileSuccess);

      setState(() {
        isSaving = false;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: translation(context).diologueUpdateProfileFailure);
    }
  }

  Future<String?> _uploadImage(File filePath) async {
    try {
      final fileName = const Uuid().v4();
      final Reference fbStorage =
          FirebaseStorage.instance.ref('profile').child(fileName);
      final UploadTask uploadTask = fbStorage.putFile(filePath);
      await uploadTask;
      return await fbStorage.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            UserSharedPreference.setUserRole('');
            navigateToLogin(context);
          },
          child: Text(translation(context).logout)),
    );
  }

  Widget _buildDeleteAccountButton() {
    return ElevatedButton(
      onPressed: () async {
        showDeleteDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: Text(
        translation(context).deleteAccount,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

showDeleteDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => DeleteProfileDialog(),
  );
}
