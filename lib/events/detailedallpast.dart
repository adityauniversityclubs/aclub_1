import 'package:aclub/auth/authService.dart';
import 'package:aclub/rollno.dart';
import 'package:flutter/material.dart';
/// Main Screen with Tabs
class ClubsScreena extends StatefulWidget {
  final String clubName;
  final String eventName;
  final DateTime date;
  final String location;
  final String description;
  final String rollNo;

  const ClubsScreena({
    super.key,
    required this.clubName,
    required this.eventName,
    required this.date,
    required this.location,
    required this.description,
    required this.rollNo
  });

  @override
  State<ClubsScreena> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreena>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.clubName} Event',
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Event Details', icon: Icon(Icons.event)),
            Tab(text: 'Members', icon: Icon(Icons.group)),
            Tab(text: 'Feedback', icon: Icon(Icons.feedback)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EventDetailsTab(
            eventName: widget.eventName,
            date:widget.date,
            location: widget.location,
            description: widget.description,
          ),
           MembersTab(eventName: widget.eventName),
          FeedbackTab(
            rollNo: widget.rollNo,
            eventName: widget.eventName,
            date:widget.date ,
            location: widget.location,
          ),
        ],
      ),
    );
  }
}

/// Tab 1: Event Details
class EventDetailsTab extends StatefulWidget {
  final String eventName;
  final DateTime date;
  final String location;
  final String description;

  const EventDetailsTab({
    super.key,
    required this.eventName,
    required this.date,
    required this.location,
    required this.description,
  });

  @override
  State<EventDetailsTab> createState() => _EventDetailsTabState();
}
class _EventDetailsTabState extends State<EventDetailsTab> {
  final AuthService authService = AuthService();
  bool _isRegister = false; // Track registration status

  @override
  void initState() {
    super.initState();
    registerStatus(); // Check status on screen load
  }

  void registerStatus() async {
    final response =
        await authService.regestrationStatus(widget.eventName, Shared().rollNo);
    if (response.containsKey('status') && response['status'] == true) {
      setState(() {
        _isRegister = true; // Update UI
      });
      print('Registered response: $response');
    } else {
      setState(() {
        _isRegister = false; // Update UI
      });
    }
  }

  void registerEvent() async {
    final response =
        await authService.registerEvent(widget.eventName, Shared().rollNo);
    if (response.containsKey('status') && response['status'] == true) {
      setState(() {
        _isRegister = true; // Update status after successful registration
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully registered'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['msg'] ?? "Unknown error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/event_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Event: ${widget.eventName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Date: ${widget.date.day}/${widget.date.month}/${widget.date.year} | Location: ${widget.location}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Description:\n\n${widget.description}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRegister ? Colors.grey : Colors.blue,
                ),
                onPressed: _isRegister
                    ? null // Disable button if already registered
                    : () {
                        registerEvent(); // Call register function
                      },
                child: Text(_isRegister ? 'Registered' : 'Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/// Tab 2: Members List
class MembersTab extends StatefulWidget {
  final String eventName;
  const MembersTab({super.key,required this.eventName});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRegistered();
  }
  final AuthService authService=AuthService();
  List<dynamic>listMembers=[];

  void getRegistered() async {
    final response = await authService.allRegesteredStudents(widget.eventName);
    print('response data:$response');
    if (response.containsKey('status') && response['status'] == true) {
      setState(() {
        listMembers = response['registered users'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['msg'] ?? "Unknown error")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Registered Members:${listMembers.length}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount:listMembers.length ,
            itemBuilder: (context, index) {
              return ListTile(
                leading:const CircleAvatar(
                  radius: 25,
                ),
              title: Text(listMembers[index]['rollNo']),
              subtitle: Text(listMembers[index]['name']),
              
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Tab 3: Feedback
class FeedbackTab extends StatefulWidget {
  final String eventName;
  final DateTime date;
  final String location;
  final String rollNo;

  const FeedbackTab({
    super.key,
    required this.eventName,
    required this.date,
    required this.location,
    required this.rollNo,
  });

  @override
  State<FeedbackTab> createState() => _FeedbackTabState();
}

class _FeedbackTabState extends State<FeedbackTab> {
  @override
  void initState() {
    super.initState();
    getFeedback();
  }

  final AuthService authService = AuthService();
  final TextEditingController _feedbackController = TextEditingController();
  final List<String> feedbacks = [
    'Great event!',
    'Really enjoyed the presentation.',
  ];

  int _selectedStars = 0;
  bool _isSubmitted = false;
  bool _isTextEntered = false;
  bool _isLoading = false;

  List<dynamic> feedbackMsgs = [];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _onFeedbackTextChanged(String text) {
    setState(() {
      _isTextEntered = text.isNotEmpty;
    });
  }

  void _updateRating(int index) {
    if (!_isSubmitted && _isTextEntered) {
      setState(() {
        _selectedStars = index + 1;
      });
    }
  }

  void _submitFeedback() {
    if (_selectedStars > 0 && _isTextEntered) {
      setState(() {
        _isSubmitted = true;
        feedbacks.add(_feedbackController.text);
        _feedbackController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('Feedback submitted successfully with $_selectedStars '),
              Icon(Icons.star, color: Colors.orange),
            ],
          ),
        ),
      );
    }
  }

  // Submit feedback to the backend API
  Future<void > submitFeedback() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    final response = await authService.giveFeedBack(
      widget.eventName,
      _feedbackController.text.trim(),
      _selectedStars,
      widget.rollNo,
    );

    if (response.containsKey('status') && response['status'] == true) {
      _submitFeedback(); // Update the feedback list in the app
      getFeedback(); // Fetch the latest feedback
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['msg'] ?? "Unknown error")),
      );
    }

    setState(() {
      _isLoading = false; // Stop loading
    });
  }

  // Get feedback from the backend API
  void getFeedback() async {
    final response = await authService.getFeedBack(widget.eventName);

    if (response.containsKey('status') && response['status'] == true) {
      setState(() {
        feedbackMsgs = response['feedbacks'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['msg'] ?? "Unknown error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event: ${widget.eventName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Date: ${widget.date} | Location: ${widget.location}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Your Feedback:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your feedback here',
            ),
            maxLines: 3,
            enabled: !_isSubmitted,
            onChanged: _onFeedbackTextChanged,
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rating:', style: TextStyle(fontSize: 18)),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: _isTextEntered ? () => _updateRating(index) : null,
                    child: Icon(
                      index < _selectedStars ? Icons.star : Icons.star_border,
                      color: index < _selectedStars ? Colors.orange : Colors.black,
                      size: 25,
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _isSubmitted || _selectedStars == 0 || !_isTextEntered || _isLoading
                  ? null
                  : () async {
                      await submitFeedback();
                     setState(() {
                        _feedbackController.clear();
                        _selectedStars=0;
                     }); // Wait for feedback submission
                    },
              child: _isLoading
                  ? CircularProgressIndicator() // Show loading spinner
                  : Text(_isSubmitted ? 'Feedback Submitted' : 'Submit Feedback'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Feedback from others:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          feedbackMsgs.isEmpty
              ? Center(child: Text('No feedback available'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: feedbackMsgs.length,
                  itemBuilder: (context, index) {
                    final feedback = feedbackMsgs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(feedback['rollNo'] ?? 'Unknown'),
                        subtitle: Text(feedback['feedback'] ?? 'No feedback provided'),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

