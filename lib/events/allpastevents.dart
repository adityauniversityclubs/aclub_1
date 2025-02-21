// import 'package:aclub/events/detailedallpast.dart';
// import 'package:aclub/rollno.dart';
import 'package:flutter/material.dart';
import 'package:aclub/auth/authService.dart';

class Allpastevents extends StatefulWidget {
  const Allpastevents({super.key});

  @override
  State<Allpastevents> createState() => _AllpasteventsState();
}

class _AllpasteventsState extends State<Allpastevents> {
  final AuthService authService = AuthService();
  List<dynamic> events = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
      void getData() async {
    final response = await authService.allPastEvents();
    if (response.containsKey('status') && response['status'] == true) {
      setState(() {
        events = response['past events']; // Store fetched events
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Past Events")),
      body: Column(
        children: [
          TextButton(
            onPressed: (){},
            child: Text('Get Events'),
          ),
          Expanded(
            child: events.isEmpty
                ? Center(child: Text("No events found"))
                : ListView.builder(
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>ClubsScreena(clubName: events[index]['clubName'], eventName: events[index]['eventName'], date: DateTime.parse(events[index]['date']), location:events[index]['location'], description:events[index]['details'],rollNo: Shared().rollNo,)));
                        },
                          child: Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              events[index]["clubName"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
