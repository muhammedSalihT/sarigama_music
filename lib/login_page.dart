import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sarigama_music1/src/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String sharedName = 'say';
const String sharedNum = 'num';
const String sharedCheck = 'check';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  var _formkey;
    final _usernamecontroler =TextEditingController();
    final _mobileController =TextEditingController();
   
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                      "assets/images/istockphoto-939443944-612x612.jpg"),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: InkWell(
                splashColor: const Color.fromARGB(255, 26, 114, 158),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 250.0, left: 30, right: 30),
                    child: Form(
                    //  key: _formkey,
                      child: Column(children: [
                        TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w900,
                            ),
                            controller: _usernamecontroler,
                            decoration: const InputDecoration(
                                prefix: Icon(Icons.verified_user),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: ' ENTER USERNAME',
                                hintStyle: TextStyle(color: Colors.black)),
                          
                            ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w900,
                            ),
                            controller: _mobileController,
                            decoration: const InputDecoration(
                                prefix: Icon(Icons.phone_android),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                hintText: ' ENTER MOBILE NUMBER',
                                hintStyle: TextStyle(color: Colors.black)),
                          
                            ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 200.0,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                primary: const Color(0xff4E0B0B),
                                textStyle: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              final SharedPreferences shared =
                                  await SharedPreferences.getInstance();
                              shared.setString(
                                sharedName,
                                _usernamecontroler.text,
                              );
                             shared.setString(sharedNum, _mobileController.text);
                              shared.setBool(sharedCheck, true);

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) => const HomePage())),
                              );
                            },
                            icon: const Icon(
                              Icons.login_sharp,
                              size: 30.0,
                            ),
                            label: const Text("Let's go"),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              )),
        ));
  }
}
