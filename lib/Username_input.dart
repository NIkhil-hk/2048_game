import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/presentation/pages/home_page/home_page.dart';

import 'package:hive_flutter/hive_flutter.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({super.key});

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  final GlobalKey<FormState> _UsernameKey = GlobalKey();
  TextEditingController username = new TextEditingController();
  final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9]+$');

  DatabaseReference use = FirebaseDatabase.instance.ref('Usernames');
  bool _usernameAvailable = false;

  @override
  void initState() {
    super.initState();
    username.addListener(_checkUsernameAvailability);
  }

  @override
  void dispose() {
    username.removeListener(_checkUsernameAvailability);
    super.dispose();
  }

  void _checkUsernameAvailability() async {
    final name = username.text;
    if (name.isEmpty) {
      setState(() {
        _usernameAvailable = false;
      });
    }
    if (name.isNotEmpty) {
      final snapshot = await use.get();
      final dataMap = snapshot.value as Map<dynamic, dynamic>;

      setState(() {
        if (!_usernameRegExp.hasMatch(name)) {
          _usernameAvailable = false;
        } else if (dataMap.containsKey(username.text)) {
          _usernameAvailable = false;
        } else {
          _usernameAvailable = true;
        }
      });
    }
  }

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    if (_boxLogin.get("loginStatus") ?? false) {
      return HomePage();
    }
    return Scaffold(
        backgroundColor: Color(0xff0045e8),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffe2b7f6),
                  Color(0xff0045e8),
                ],
              ),
            ),
            child: Column(
              children: [
                Form(
                  key: _UsernameKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          '2048',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Select an Aesthetic Username to Rock",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: username,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white), // Focus border color
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.person_outline),
                            suffixIcon: _usernameAvailable
                                ? Icon(Icons.check,
                                    color: Color.fromARGB(255, 184, 234, 192))
                                : Icon(Icons.close,
                                    color: Color.fromARGB(255, 250, 170, 164)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter username.";
                            } else if (!_usernameRegExp
                                .hasMatch(username.text)) {
                              return "Use only letters and numbers.";
                            } else if (!_usernameAvailable) {
                              return "Username not available.";
                            } else if (username.text.length > 15) {
                              return "Less than 15 characters please.";
                            }
                            // else if (!_boxAccounts.containsKey(value)) {
                            //   return "Username is not registered.";
                            // }

                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        !_usernameAvailable
                            ? Text(
                                'Username not Available',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 247, 175, 171)),
                              )
                            : Text(
                                'Username Available',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 158, 247, 161)),
                              ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                if (_UsernameKey.currentState?.validate() ??
                                    false) {
                                  use.child(username.text).set({
                                    "Username": username.text,
                                    "3x3": 0,
                                    "4x4": 0
                                  });

                                  _boxLogin.put("loginStatus", true);
                                  _boxLogin.put("userName", username.text);

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              },
                              child: const Text("Create Username"),
                            ),
                            SizedBox(
                              height: 200,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
