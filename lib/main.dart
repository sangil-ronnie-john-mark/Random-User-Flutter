import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main()=> runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: MyApp(),
    )
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> data = [];
  String? name;
  String? gender;
  String? location;
  String? email;
  String? username;
  String? age;
  String? phone;

  Future<void> _getUserData() async {
    final url = "https://randomuser.me/api/";
    final response = await http.get(
      Uri.parse(url)
    );
      setState(() {
        data = List<Map<String, dynamic>>.from([jsonDecode(response.body)]);
      });

    print(data[0]['results'][0]['email']);
    name = data[0]['results'][0]['name']['title'] + ' ' + data[0]['results'][0]['name']['first'] + ' ' +data[0]['results'][0]['name']['last'];
    gender = data[0]['results'][0]['gender'];
    location=data[0]['results'][0]['location']['country'];
    email=data[0]['results'][0]['email'];
    username=data[0]['results'][0]['login']['username'];
    age=data[0]['results'][0]['dob']['age'].toString();
    phone=data[0]['results'][0]['phone'];
  }
  @override
  void initState() {
    _getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('ID'),
        centerTitle: true,
      ),
      body: RefreshIndicator(child: ListView(
        children: [
         data.isNotEmpty?   Container(
           padding: EdgeInsets.all(10),
           child: Column(
             children: [
               //Container for the image and name
               Container(
                   padding: EdgeInsets.all(20),
                   width: double.maxFinite,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Column(
                     children: [
                       ClipOval(child: Image.network(data[0]['results'][0]['picture']['large'])),
                       SizedBox(height: 20,),
                       Text('$name', style: TextStyle(fontWeight: FontWeight.bold),)
                     ],
                   )),
               SizedBox(height: 20,),
               Container(
                   padding: EdgeInsets.all(20),
                   width: double.maxFinite,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon((gender == "male"? Icons.male_outlined : Icons.female_outlined), color: (gender == "male"? Colors.blue:Colors.pink),),
                           Text('$gender'),
                         ],
                       ),
                       SizedBox(height: 15,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.pin_drop_outlined, color: Colors.red,),
                           Text('$location'),
                         ],
                       ),
                       SizedBox(height: 15,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.email_outlined, color: Colors.yellow[800],),
                           Text('$email'),
                         ],
                       ),
                       SizedBox(height: 15,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.person_outline, color: Colors.green[800],),
                           Text('$username'),
                         ],
                       ),
                       SizedBox(height: 15,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.calendar_today_outlined, color: Colors.blue[800],),
                           Text('$age'),
                         ],
                       ),
                       SizedBox(height: 15,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.phone_android_outlined, color: Colors.purple[800],),
                           Text('$phone'),
                         ],
                       ),
                     ],
                   )),
             ],
           ),
           ) : Column(
             children: [
             Text('Loading Data'),
             SizedBox(height: 20,),
             CircularProgressIndicator()
           ],
         )
        ],
      ), onRefresh: _getUserData)
    );
  }
}
