import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terracred/buttons/sub_button.dart';
import 'package:terracred/community-chat/feed/feed_screen.dart';
import 'package:terracred/community-chat/post/controller/post_controller.dart';
import 'package:terracred/community-chat/post/screens/add_post_screen.dart';
import 'package:terracred/db/shared_pref.dart';
import 'package:terracred/model/post.dart';
import 'package:terracred/navigators.dart';

// ignore: constant_identifier_names
const String pregathiWebsiteLink = "https://pregathi-website.vercel.app/";
const String pregathiAboutUsLink= "https://ahkharsha.github.io/assets/pregAthI/videos/aboutUs.mp4";
String pregathiSupportEmail= 'pregathi2024@gmail.com';

const apiKey = "AIzaSyCAYDrBcb41UV2-2inRihCUS80VdRWv6vs";
const bannerDefault = 'https://st.adda247.com/https://wpassets.adda247.com/wp-content/uploads/multisite/sites/5/2023/10/16083857/1_bVM9Tl6tPhfZ2nmKfaB-0A.jpg';
const avatarDefault =
    'https://bsmedia.business-standard.com/_media/bs/img/article/2021-06/05/full/1622854444-6718.jpg?im=FeatureCrop,size=(826,465)';

const wifeProfileDefault =
    'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_icon_149329.png';

const volunteerProfileDefault =
    'https://t4.ftcdn.net/jpg/02/72/39/87/360_F_272398712_z28EMWLbM9Y8zojg51tLZo4D8Ju3R7EG.jpg';

const musicImageDefault = 'https://media.wired.com/photos/5926df59f3e2356fd800ab80/master/w_1920,c_limit/GettyImages-543338600-S2.jpg';

// Disha's
Color primaryColor = Color.fromARGB(255, 110, 174, 110);
// Color textColor = Color.fromARGB(255, 174, 110, 165);

// Harsha's
// Color primaryColor = Color.fromARGB(255, 158, 59, 144);

// Final
Color textColor = Color.fromARGB(255, 11, 93, 25);

// Color appBgColor=Color.fromARGB(255, 252, 213, 246);
Color appBgColor = Color.fromARGB(255, 239, 253, 243);

Color boxColor = Colors.white;

const tabWidgets = [
  FeedScreen(),
  AddPostScreen(),
];

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    ),
  );
}

dialogueBoxWithButton(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        SubButton(
          title: 'Ok',
          onPressed: () => goBack(context),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}




logoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Do you want to log out?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        SubButton(
          title: 'No',
          onPressed: () => goBack(context),
        ),
        SubButton(
          title: 'Yes',
          onPressed: () async {
            goBack(context);
            await FirebaseAuth.instance.signOut();
            await UserSharedPreference.setUserRole('');
            navigateToLogin(context);
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}

deletePostConfirmation(Post post, WidgetRef ref, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Do you want to delete the post?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        SubButton(
          title: 'No',
          onPressed: () => goBack(context),
        ),
        SubButton(
          title: 'Yes',
          onPressed: () async {
            deletePost(post, ref, context);
            goBack(context);
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    ),
  );
}

void deletePost(Post post, WidgetRef ref, BuildContext context) async {
  ref.read(postControllerProvider.notifier).deletePost(post, context);
}

Widget progressIndicator(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: textColor,
      color: appBgColor,
      strokeWidth: 7,
    ),
  );
}

Widget smallProgressIndicator(BuildContext context) {
  return Center(
    child: Transform.scale(
      scale: 0.7,
      child: CircularProgressIndicator(
        backgroundColor: primaryColor,
        color: appBgColor,
        strokeWidth: 7,
      ),
    ),
  );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}

List<String> bannedWords = [
  'fuck',
  'motherfucker',
  'fucker',
  'asshole',
  'shit',
  'bitch',
  'cunt',
  'bastard',
  'cock',
  'dick',
  'pussy',
  'whore',
  'slut',
  'nigger',
  'nigga',
  'faggot',
  'retard',
  'twat',
  'wanker',
  'arsehole',
  'bollocks',
  'douchebag',
  'sucker',
  'cuck',
  'dildo',
  'asshat',
  'anus',
  'spastic',
  'bugger',
  'knob',
  'sperm',
  'cum',
  'tits',
  'boobs',
  'titfuck',
  'nipple',
  'vagina',
  'penis',
  'testicle',
  'balls',
  'pubes',
  'clit',
  'fanny',
];

bool checkForBannedWords(String text) {
    for (String word in bannedWords) {
      if (text.toLowerCase().contains(word.toLowerCase())) {
        return true;
      }
    }
    return false;
  }