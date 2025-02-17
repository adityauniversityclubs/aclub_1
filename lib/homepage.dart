import 'package:aclub/events/allpastevents.dart';
import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Allpastevents()));
      },
        child: Text("HomeScreen")),),
    );
  }
}