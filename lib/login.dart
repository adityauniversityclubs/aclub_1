import 'package:aclub/authService.dart';
import 'package:aclub/forgot.dart';
import 'package:aclub/homepage.dart';
import 'package:aclub/rollno.dart';
import 'package:flutter/material.dart';
class SimpleLoginScreen extends StatefulWidget {
  final Function(String? rollNumber, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, super.key});

  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String rollNumber, password;
  String? rollNumberError, passwordError;
  bool _obscurePassword = true;
  AuthService authService=AuthService();
  @override
  void initState() {
    super.initState();
    rollNumber = '';
    password = '';
  }

  void _resetErrorText() {
    setState(() {
      rollNumberError = null;
      passwordError = null;
    });
  }

  bool _validateInputs() {
    
    _resetErrorText();
    bool isValid = true;

    if (rollNumber.isEmpty) {
      setState(() => rollNumberError = 'Please enter your roll number');
      isValid = false;
    }
    if (password.isEmpty) {
      setState(() => passwordError = 'Please enter your password');
      isValid = false;
    }
    return isValid;
  }
 void login()async{
  _validateInputs();
  print(rollNumber);
  print(password);
final response=await authService.signUser(rollNumber, password);
if(response.containsKey('status')&&response['status']==true){
  Shared().rollNo=rollNumber;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully logedin")));
  
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
}else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response['msg']}")));
}
 }
 

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              Image.asset('assets/images/AU.png', height: screenHeight / 6, width: screenWidth / 9),
              SizedBox(height: screenHeight * 0.04),
              const Text('Welcome,', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Sign in to continue!', style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6))),
              SizedBox(height: screenHeight * 0.08),
              _buildTextField(
                label: 'Roll Number',
                errorText: rollNumberError,
                onChanged: (value) => setState(() => rollNumber = value),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                label: 'Password',
                errorText: passwordError,
                obscureText: true,
                isPasswordField: true,
                onChanged: (value) => setState(() => password = value),
              ),
            
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                  },

                  
                  child: const Text('Forgot Password?', style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? errorText,
    bool obscureText = false,
    bool isPasswordField = false,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPasswordField
            ? IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
      ),
      obscureText: isPasswordField ? _obscurePassword : obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const Text(
        'Log In',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}