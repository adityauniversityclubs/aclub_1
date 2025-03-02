import 'package:flutter/material.dart';

class ClubMembersList extends StatelessWidget {
  final List<Map<String, String>> members = [
    {'name': 'John Doe', 'rollNumber': '12345', 'phoneNumber': '9876543210'},
    {'name': 'Jane Smith', 'rollNumber': '12346', 'phoneNumber': '9876543211'},
    {'name': 'Mike Johnson', 'rollNumber': '12347', 'phoneNumber': '9876543212'},
    {'name': 'Emily Davis', 'rollNumber': '12348', 'phoneNumber': '9876543213'},
    {'name': 'Chris Wilson', 'rollNumber': '12349', 'phoneNumber': '9876543214'},
    {'name': 'Sarah Brown', 'rollNumber': '12350', 'phoneNumber': '9876543215'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Members',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF040737),
                child: Text(
                  member['name']![0],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(member['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Roll No: ${member['rollNumber']}'),
                  Text('Phone: ${member['phoneNumber']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
