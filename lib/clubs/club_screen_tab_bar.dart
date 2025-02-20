
import 'package:aclub/auth/authService.dart';
import 'package:aclub/events/allpastevents.dart';
import 'package:aclub/events/detailedallpast.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:aclub/events/detailedallpast.dart';

/// Main Screen with TabBar and TabBarView
class ClubsScreen_a extends StatefulWidget {
  final String name;
  final String clubId;
  const ClubsScreen_a({super.key,required this.name,required this.clubId});

  @override
  State<ClubsScreen_a> createState() => _ClubsScreen_aState();
}

class _ClubsScreen_aState extends State<ClubsScreen_a>
    with SingleTickerProviderStateMixin {
       @override
  void initState() {
    super.initState();
    // Three tabs: Events, Bio, About
    _tabController = TabController(length: 3, vsync: this);
    liveEvents();
    upComingEvents();
    pastEvents();
  }
  late TabController _tabController;
      AuthService authService=AuthService();
  List<dynamic>liveEventList=[];
   List<dynamic>upComingEventList=[];
    List<dynamic>pastEventList=[];
  //get live events data
  void liveEvents()async{
    final response=await authService.getLiveData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print('live response:$response :${widget.clubId}');
      setState(() {
        liveEventList=response['ongoing events'];
      });
    }
  } 

  //get upComing events 
    void upComingEvents()async{
    final response=await authService.getupComingData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print("Upcoming response:$response");
      setState(() {
        upComingEventList=response['upcoming events'];
      });
    }
  } 

  //get past events 
    void pastEvents()async{
    final response=await authService.getPastData(widget.clubId);
    if(response.containsKey('status')&&response['status']==true){
      print("Past response:$response");
      setState(() {
        pastEventList=response['past events'];
      });
    }
  }
  // Data for the bio (Club info), events, and about sections
  final List<Map<String, dynamic>> groupItems = [
    {
      'title': 'Shivaji Deshmukh',
      'speaker': 'Shiva Shankar',
      'time': '3rd year',
      'duration': 'ECE',
      'profile': 'assets/NSS.png',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'SHIVA',
    },
  ];


  final List<Map<String, dynamic>> aboutItems = [
    {
      'title': 'Shivaji Babu',
      'speaker': 'Shiva Shyam',
      'time': '2nd year',
      'duration': 'EEE',
      'profile': 'assets/RED.jpg',
      'social': ['facebook', 'instagram', 'linkedin', 'web'],
      'organization': 'LEO',
    },
  ];


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Build a card for an event (non-clickable)
  Widget buildEventCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(item['profile']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(cardMargin * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Coordinator: ${item['speaker']}'),
                const SizedBox(height: 4),
                Text('Time: ${item['time']} | Category: ${item['duration']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a card for the club's bio (clickable)
  Widget buildBioCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return GestureDetector(
      onTap: () {
        // Navigate to a detailed bio page when card is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(data: item),
          ),
        );
      },
      child: Card(
        margin:
            EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: cardMargin, horizontal: cardMargin * 2),
          leading: CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: AssetImage(item['profile']),
          ),
          title: Text(
            item['organization'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
            ),
          ),
          subtitle: Text(
            'Club Leader: ${item['speaker']}\nYear: ${item['time']} | Branch: ${item['duration']}',
          ),
        ),
      ),
    );
  }

  /// Build a card for the about section (non-clickable)
  Widget buildAboutCard(BuildContext context, Map<String, dynamic> item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = screenWidth * 0.02;

    return Card(
      margin:
          EdgeInsets.symmetric(vertical: cardMargin, horizontal: cardMargin * 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(cardMargin * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['organization'],
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'About this club:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Detailed description can be added here
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Quisque ac eros nec sapien dignissim interdum. '
              'Suspendisse potenti. ',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '${widget.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto',
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shadowColor: Colors.black45,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add notification action here
            },
            tooltip: 'Notifications',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelStyle: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.normal,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              text: 'Events',
              icon: Icon(Icons.calendar_month_outlined),
            ),
            Tab(
              text: 'Bio',
              icon: Icon(Icons.person),
            ),
            Tab(
              text: 'About',
              icon: Icon(Icons.info),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
             ClubsEventScreen(clubId: widget.clubId,liveList: liveEventList,upComingList: upComingEventList,pastList: pastEventList,), // Events tab now shows ClubsEventScreen

          // Tab 1: Events (non-clickable UI)

          // Tab 2: Club Bio (clickable card)
          ListView.builder(
            itemCount: groupItems.length,
            itemBuilder: (context, index) {
              return buildBioCard(context, groupItems[index]);
            },
          ),
          // Tab 3: About section (non-clickable UI)
          ListView.builder(
            itemCount: aboutItems.length,
            itemBuilder: (context, index) {
              return buildAboutCard(context, aboutItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// Detail Screen (Common for clickable cards)
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailScreen({super.key, required this.data});

  Widget buildSocialIcons(BuildContext context, List<String> social) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.08;
    final Map<String, IconData> icons = {
      'facebook': Icons.facebook,
      'instagram': Icons.airplanemode_on_outlined,
      'linkedin': Icons.camera_alt,
      'web': Icons.language,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: social
          .map(
            (platform) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                icons[platform],
                size: iconSize,
                color: Colors.grey[700],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.2;
    final fontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['speaker'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality can be added here.
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage(data['profile']),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              data['organization'],
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.1),
            buildSocialIcons(context, data['social']),
          ],
        ),
      ),
    );
  }
}








class ClubsEventScreen extends StatefulWidget {
  final String clubId;
  final List<dynamic>liveList;
  final List<dynamic>upComingList;
   final List<dynamic>pastList;
  const ClubsEventScreen({super.key,required this.clubId,required this.liveList,required this.upComingList,required this.pastList});

  @override
  State<ClubsEventScreen> createState() => _ClubsEventScreenState();
}

class _ClubsEventScreenState extends State<ClubsEventScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([

              _buildSectionHeader('🔴Live Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Allpastevents()),
                );
              }),
              _buildListeningSection(widget.liveList),
              const SizedBox(height: 20),
              _buildSectionHeader('Upcoming Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Allpastevents()),
                );
              }),
              _buildledgeSection(widget.upComingList),
              const SizedBox(height: 18),
              _buildSectionHeader('Past Events', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (Allpastevents())),
                );
              }),
              _buildPastSection(widget.pastList),
            ]),
          ),
        ],
      ),
    );
  }
}




  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See All'),
            ),
        ],
      ),
    );
  }










  Widget _buildEventGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _buildEventCard(context, index),
    );
  }

  Widget _buildEventCard(BuildContext context, int index) {
    final List<Map<String, dynamic>> events = [
      {
        'title': 'Leadership Workshop',
        'date': 'March 25',
        'image': 'assets/ob/ob1.jpg',
        'club': 'LEO Club'
      },
      {
        'title': 'Music Festival',
        'date': 'April 2',
        'image': 'assets/ob/ob2.jpg',
        'club': 'SAC'
      },
      {
        'title': 'Coding Challenge',
        'date': 'April 5',
        'image': 'assets/ob/ob3.jpg',
        'club': 'IEDC'
      },
      {
        'title': 'Cultural Night',
        'date': 'April 8',
        'image': 'assets/ob/ob1.jpg',
        'club': 'NSS'
      },
    ];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Allpastevents(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(events[index]['image']),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                events[index]['date'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                events[index]['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Iconsax.clock, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    '6:00 PM',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 15),
      itemBuilder: (context, index) => _buildNewsCard(index),
    );
  }

  Widget _buildNewsCard(int index) {
    final List<Map<String, dynamic>> newsItems = [
      {
        'title': 'New Club Registration Open',
        'excerpt': 'Register your new student organization before April 30...',
        'date': '2h ago'
      },
      {
        'title': 'Annual Fest Schedule Released',
        'excerpt': 'Check out the complete schedule for this year\'s college fest...',
        'date': '5h ago'
      },
      {
        'title': 'Leadership Workshop Results',
        'excerpt': 'View the results of the inter-college leadership workshop...',
        'date': '1d ago'
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.info_circle, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsItems[index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      newsItems[index]['date'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            newsItems[index]['excerpt'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection(List<dynamic>list) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', list[index]['eventName'],);
      }),
    );
  }

  Widget _buildListeningCard(String imagePath, String episode,) {
    return GestureDetector(onTap: (){
      
    },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Text(
              episode,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
  //  Widget _buildKnowledgeSection(List<dynamic>list) {
  //   return SizedBox(
  //     width: 150,
  //     height: 150,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount:list.length ,
  //       itemBuilder: (context,index){
  //     return  _buildListeningCard('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', list[index]['eventName']);
  //     }),
  //   );
  // }




  Widget _buildledgeSection(List<dynamic>list) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', list[index]['eventName']);
      }),
    );
  }


Widget _buildPastSection(List<dynamic>list) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:list.length ,
        itemBuilder: (context,index){
      return  _buildListeningCard('https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', list[index]['eventName']);
      }),
    );
  }