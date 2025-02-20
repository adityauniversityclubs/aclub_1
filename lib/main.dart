import 'package:aclub/home/homepage.dart';
import 'package:aclub/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:aclub/auth/authService.dart';
//import 'package:aclub/clubs/club_screen_tab_bar.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //Allpastevents(),
      // SimpleRegisterScreen(),
     // ClubsScreen_a(),
    );
  }
}

class SimpleRegisterScreen extends StatefulWidget {
  const SimpleRegisterScreen({super.key});

  @override
  State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
 AuthService authService = AuthService();
  final TextEditingController firstcntrl = TextEditingController();
  final TextEditingController lastcntrl = TextEditingController();
  final TextEditingController rollcntrl = TextEditingController();
  final TextEditingController phonecntrl = TextEditingController();
  final TextEditingController passcntrl = TextEditingController();

  void register() async {
    final response = await authService.registerUser(
      firstcntrl.text.trim(),
      lastcntrl.text.trim(),
      rollcntrl.text.trim(),
      phonecntrl.text.trim(),
      passcntrl.text.trim(),
    );

    if (response.containsKey('status') && response['status'] == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Successfully registered")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SimpleLoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['msg'] ?? "Unknown error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Image.network(
                'assets/logo/AU.png',
                height: 100,
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'Create Account,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started!',
                style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildInputField(label: 'First Name', controller: firstcntrl),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Last Name', controller: lastcntrl),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Roll No', controller: rollcntrl, keyboardType: TextInputType.number),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Phone No', controller: phonecntrl, keyboardType: TextInputType.phone),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Password', controller: passcntrl, obscureText: true),
              SizedBox(height: screenHeight * 0.025),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        minimumSize: Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSignInText(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpleLoginScreen()),
      ),
      child: RichText(
        text: const TextSpan(
          text: "I'm already a member, ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
