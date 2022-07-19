import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sarigama_music1/functions/playlist_fun.dart';
import 'package:sarigama_music1/src/main/login_page.dart';
import 'package:sarigama_music1/src/main/main.dart';
import 'package:sarigama_music1/src/home/user_detail_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String name = '';
String num = '';
String subName = 'Unknown';
String subNum = 'Empty';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  DateTime timeBackPressed = DateTime.now();
  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isExitWarning = diffrence >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = 'Press back again to exit from App';
          Fluttertoast.showToast(
              msg: message,
              fontSize: 18,
              backgroundColor: Color.fromARGB(188, 235, 229, 229));
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                width: double.infinity,
                child: const CircleAvatar(
                  child: Image(
                      image: AssetImage(
                          'assets/images/image-removebg-preview.png')),
                  backgroundColor: Color.fromARGB(255, 93, 75, 56),
                )),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * .09,
              ),
              child: Column(
                children: [
                  const SizedBox(),
                  GestureDetector(
                    child: UserDetailsWidget(
                      iconData: Icons.person_outline,
                      title: _setName(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: UserDetailsWidget(
                        iconData: Icons.mobile_friendly, title: _setNum()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl();
                    },
                    child: UserDetailsWidget(
                        iconData: Icons.feedback_outlined, title: 'Contact Us'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'Hey! check out this new app https://play.google.com/store/apps/details?id=com.fouty.sarigama');
                    },
                    child: UserDetailsWidget(
                        iconData: Icons.share_outlined,
                        title: 'Share this app'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // ignore: deprecated_member_use
                      if (await launch(
                          'https://play.google.com/store/apps/details?id=com.fouty.sarigama')) {
                        throw 'Could not launch';
                      }
                    },
                    child: UserDetailsWidget(
                        iconData: Icons.star_border_outlined,
                        title: 'Rate our app'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await launch(
                          'https://play.google.com/store/apps/details?id=com.fouty.sarigama')) {
                        throw 'Could not launch';
                      }
                    },
                    child: UserDetailsWidget(
                        iconData: Icons.info_outline, title: 'About'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.clear();
                      resetApp();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: UserDetailsWidget(
                        iconData: Icons.exit_to_app_outlined, title: 'Logout'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getValue() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var getName = sharedPreferences.getString(sharedName);
    var getnum = sharedPreferences.getString(sharedNum);

    setState(() {
      name = getName!;
      num = getnum!;
    });
  }

  _setName() {
    if (name.isEmpty) {
      return subName;
    } else {
      return name;
    }
  }

  _setNum() {
    if (num.isEmpty) {
      return subNum;
    } else {
      return num;
    }
  }

  Future<void> _launchUrl() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:mhdsalih9656@gmail.com')) {
      throw 'Could not launch';
    }
  }
}
