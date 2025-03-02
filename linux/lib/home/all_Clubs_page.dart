import 'package:flutter/material.dart';

// MyEPage Widget
class MyEPage extends StatefulWidget {
  const MyEPage({super.key});

  @override
  _MyEPageState createState() => _MyEPageState();
}

class _MyEPageState extends State<MyEPage> {
  // List of clubs
  final List<Club> clubs = [
    Club(
      title: "Google Developer Group",
      image: "assets/clublogo/GDG.png",
      description: "Connect with a global network of developers and tech enthusiasts through innovative workshops and hackathons.",
    ),
    Club(
      title: "LEO Club",
      image: "assets/clublogo/LEO.png",
      description: "Develop leadership skills and engage in community service with peers in a supportive environment.",
    ),
    Club(
      title: "NSS Club",
      image: "assets/clublogo/NSS.png",
      description: "Participate in impactful social initiatives and volunteer projects to make a real difference in society.",
    ),
    Club(
      title: "Red Cross Club",
      image: "assets/clublogo/RED.png",
      description: "Learn lifesaving skills and promote humanitarian values while serving your community.",
    ),
    Club(
      title: "Rotary Club",
      image: "assets/clublogo/ROT.png",
      description: "Collaborate with professionals and community leaders to drive positive change locally and globally.",
    ),
    Club(
      title: "Student Activity Council",
      image: "assets/clublogo/SAC.png",
      description: "Shape campus life by organizing events, voicing student concerns, and fostering an inclusive community.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate backward
          },
        ),
        title: const Text("Clubs"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: clubs.length,
                  itemBuilder: (context, index) {
                    return ProgramCard(club: clubs[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show more options dialog
  void _showMoreOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('More Options'),
          content: const Text('You can add more features here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Club Model
class Club {
  final String title;
  final String image;
  final String description;

  Club({
    required this.title,
    required this.image,
    required this.description,
  });
}

// ProgramCard Widget
class ProgramCard extends StatelessWidget {
  final Club club;

  const ProgramCard({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth / 2; // Image size set to half the screen width

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Image container with white background
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 255, 255, 255), // Set background color to white
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Optional: adjust padding to your liking
              child: Image.asset(
                club.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Text container next to the image
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    club.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    club.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


