import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:game_2048/Username_input.dart';
import 'package:game_2048/presentation/pages/home_page/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final Box _boxLogin = Hive.box("login");
  DatabaseReference usernames = FirebaseDatabase.instance.ref('Usernames');
  String username = "User";
  int score3x3 = 0;
  int score4x4 = 0;
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    get_info();
  }

  void get_info() async {
    final snpp = await usernames.child(_boxLogin.get('userName')).get();

    
    Map<dynamic, dynamic> values = snpp.value as Map;
    setState(() {
      score3x3 = values['3x3'];
      score4x4 = values['4x4'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0045e8),
      body: SingleChildScrollView(child: Container(
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
            Row(),
            SizedBox(
              height: 100,
            ),
            Text(
              _boxLogin.get('userName'),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  '4x4 Score',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$score4x4',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  '3x3 Score',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$score3x3',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 187, 243, 189),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text("Menu"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Don\'t like the username ?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
                  'You can save the score and create a new Username.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 15,),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 247, 157, 150),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                _boxLogin.clear();
                _boxLogin.put("loginStatus", false);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UsernameInput()));
              },
              child: Text("Create another Username"),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),)
    );
  }
}
