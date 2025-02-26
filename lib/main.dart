import 'package:aclub/home/homepage.dart';
import 'package:aclub/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:aclub/auth/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aclub/home/bottom_Navbar.dart';
//import 'package:aclub/clubs/club_screen_tab_bar.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
  String? rollNo = prefs.getString('rollno');
  runApp( MyApp(startingPage: rollNo != null ? Nav_Bar(val: 0) : SimpleLoginScreen()));
}

class MyApp extends StatelessWidget {
  final Widget startingPage;
  const MyApp({super.key,required this.startingPage});

  @override

  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      // Nav_Bar(val: 0),
       startingPage
      //HomeScreen(),
      //Allpastevents(),
 
      // SimpleRegisterScreen(),
     // ClubsScreen_a(),
    );
  }
}

//SignUp
class SimpleRegisterScreen extends StatefulWidget {
  const SimpleRegisterScreen({super.key});

  @override
  State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  final AuthService authService = AuthService();
  final TextEditingController firstcntrl = TextEditingController();
  final TextEditingController lastcntrl = TextEditingController();
  final TextEditingController rollcntrl = TextEditingController();
  final TextEditingController phonecntrl = TextEditingController();
  final TextEditingController passcntrl = TextEditingController();
  String? firstnameError, lastnameError, rollNoError, phonenoError, passwordError;

  bool isValid = true;

  void _resetErrorText() {
    setState(() {
      firstnameError = null;
      lastnameError = null;
      rollNoError = null;
      phonenoError = null;
      passwordError = null;
    });
  }

  void register() async {
    _resetErrorText();

    if (firstcntrl.text.isEmpty) {
      setState(() => firstnameError = 'Please enter your first name');
      isValid = false;
    }
    if (lastcntrl.text.isEmpty) {
      setState(() => lastnameError = 'Please enter your last name');
      isValid = false;
    }
    if (rollcntrl.text.isEmpty) {
      setState(() => rollNoError = 'Please enter your roll number');
      isValid = false;
    }
    if (phonecntrl.text.isEmpty) {
      setState(() => phonenoError = 'Please enter your phone number');
      isValid = false;
    }
    if (passcntrl.text.isEmpty) {
      setState(() => passwordError = 'Please enter your password');
      isValid = false;
    }

    if (!isValid) return;

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
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SimpleLoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['msg'] ?? "Unknown error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
          children: [
      Stack(
      children: [
      ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: screenHeight * 0.24,
        width: screenWidth,
        color: Color(0xFF040737),
            ),
            ),
            Positioned(
        top: screenHeight * 0.05,
      left: screenWidth * 0.30,
      child: Image.asset(
        'assets/ACLUB.png',
        height: screenHeight / 10,
        width: screenWidth / 3,
               ),
            ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child:Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Sign up to get started!', style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildInputField(label: 'First Name', controller: firstcntrl, errorText: firstnameError),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Last Name', controller: lastcntrl, errorText: lastnameError),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Roll No', controller: rollcntrl,errorText: rollNoError),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Phone No', controller: phonecntrl, keyboardType: TextInputType.phone, errorText: phonenoError),
              SizedBox(height: screenHeight * 0.024),
              _buildInputField(label: 'Password', controller: passcntrl, obscureText: true, errorText: passwordError),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF040737),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.016,
                          horizontal: screenWidth * 0.37,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    _buildSignInText(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {
          if (controller == firstcntrl) firstnameError = null;
          if (controller == lastcntrl) lastnameError = null;
          if (controller == rollcntrl) rollNoError = null;
          if (controller == phonecntrl) phonenoError = null;
          if (controller == passcntrl) passwordError = null;
        });
      },
      decoration: InputDecoration(
        // hintText:errorText ,
        // hintStyle:TextStyle(fontSize: 16,color: Colors.black) ,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF040737), width: 1),
        ),
        errorText: errorText,
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?", style: TextStyle(fontSize: 16, color: Colors.black)),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SimpleLoginScreen()),
          ),
          child: Text(' Sign In',
            style: TextStyle(fontSize: 17,color: Color(0xFF3B7CD6), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 50);
    path.quadraticBezierTo(3 * size.width / 4, size.height - 100, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}














// class SimpleRegisterScreen extends StatefulWidget {
//   const SimpleRegisterScreen({super.key});

//   @override
//   State<SimpleRegisterScreen> createState() => _SimpleRegisterScreenState();
// }

// class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
//  AuthService authService = AuthService();
//   final TextEditingController firstcntrl = TextEditingController();
//   final TextEditingController lastcntrl = TextEditingController();
//   final TextEditingController rollcntrl = TextEditingController();
//   final TextEditingController phonecntrl = TextEditingController();
//   final TextEditingController passcntrl = TextEditingController();

//   void register() async {
//     final response = await authService.registerUser(
//       firstcntrl.text.trim(),
//       lastcntrl.text.trim(),
//       rollcntrl.text.trim(),
//       phonecntrl.text.trim(),
//       passcntrl.text.trim(),
//     );

//     if (response.containsKey('status') && response['status'] == true) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Successfully registered")));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SimpleLoginScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(response['msg'] ?? "Unknown error")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFFD5D5), Color(0xFFFFA07A)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ListView(
//             children: [
//               SizedBox(height: screenHeight * 0.1),
//               Image.network(
//                 'assets/logo/AU.png',
//                 height: 100,
//               ),
//               SizedBox(height: screenHeight * 0.04),
//               const Text(
//                 'Create Account,',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign up to get started!',
//                 style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               _buildInputField(label: 'First Name', controller: firstcntrl),
//               SizedBox(height: screenHeight * 0.024),
//               _buildInputField(label: 'Last Name', controller: lastcntrl),
//               SizedBox(height: screenHeight * 0.024),
//               _buildInputField(label: 'Roll No', controller: rollcntrl, keyboardType: TextInputType.number),
//               SizedBox(height: screenHeight * 0.024),
//               _buildInputField(label: 'Phone No', controller: phonecntrl, keyboardType: TextInputType.phone),
//               SizedBox(height: screenHeight * 0.024),
//               _buildInputField(label: 'Password', controller: passcntrl, obscureText: true),
//               SizedBox(height: screenHeight * 0.025),
//               Center(
//                 child: Column(
//                   children: [
//                     ElevatedButton(
//                       onPressed: register,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         minimumSize: Size(double.infinity, 56),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(26),
//                         ),
//                       ),
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     _buildSignInText(context),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }

//   Widget _buildSignInText(BuildContext context) {
//     return TextButton(
//       onPressed: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => const SimpleLoginScreen()),
//       ),
//       child: RichText(
//         text: const TextSpan(
//           text: "I'm already a member, ",
//           style: TextStyle(color: Colors.black),
//           children: [
//             TextSpan(
//               text: 'Sign In',
//               style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
