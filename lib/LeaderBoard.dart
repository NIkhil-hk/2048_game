import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeaderBoard_page extends StatefulWidget 
{
  const LeaderBoard_page({super.key});

  @override
  State<LeaderBoard_page> createState() => _LeaderBoard_pageState();
}

class _LeaderBoard_pageState extends State<LeaderBoard_page> {
  final db = FirebaseDatabase.instance.ref("Usernames");
  List<Map<dynamic, dynamic>> _dataList4x4 = [];
  List<Map<dynamic, dynamic>> _dataList3x3 = [];

  void data() async {
    final snapp = await db.get();
    Map<dynamic, dynamic> values = snapp.value as Map;
    setState(() {
      _dataList3x3.clear();
      _dataList4x4.clear();

      values.forEach((key, value) {
        _dataList4x4.add(value);
        _dataList3x3.add(value);
      });
      _dataList4x4.sort((a, b) => b['4x4'].compareTo(a['4x4']));
      _dataList3x3.sort((a, b) => b['3x3'].compareTo(a['3x3']));
      _dataList4x4.forEach((value) {});
    });
  }

  @override
  void initState() {
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "LeaderBoard",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                // Customize the tabs' appearance
                labelColor: Color.fromARGB(255, 0, 0, 0),
                indicatorColor: Color.fromARGB(
                    255, 24, 13, 244), // Selected tab label color
                unselectedLabelColor: Color.fromARGB(
                    255, 89, 98, 85), // Unselected tab label color
                labelStyle: TextStyle(
                  fontSize: 20, // Increase font size
                  fontWeight: FontWeight.bold, // Bold font weight
                ),
                tabs: [
                  Tab(text: '4x4 Top Score'),
                  Tab(text: '3x3 Top Score'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: _dataList4x4.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          
                          title: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text('${index + 1}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              Expanded(
                                child: Text(
                                  _dataList4x4[index]['Username'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                  child: Text(' ${_dataList4x4[index]['4x4']}',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                            ],
                          ),

                          // You can add more fields here as needed
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: _dataList3x3.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          
                          title: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text('${index + 1}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              Expanded(
                                child: Text(
                                  _dataList3x3[index]['Username'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                  child: Text(' ${_dataList3x3[index]['3x3']}',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                            ],
                          ),

                          // You can add more fields here as needed
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
