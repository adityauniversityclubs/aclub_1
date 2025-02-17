import 'package:aclub/login.dart';
import 'package:flutter/material.dart';
import 'authService.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _rollNumberController = TextEditingController();
  final AuthService authService=AuthService();
  void _sendOtp() {
    String rollNumber = _rollNumberController.text.trim();
    if (rollNumber.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordReset(rollNumber: rollNumber),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your roll number")),
      );
    }
  }
  void forgotPass()async{
    final response= await authService.forgotPass(_rollNumberController.text.trim());
    if(response.containsKey('status')&&response['status']==true){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("OTP Sent Successfully")));
          _sendOtp();
    }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['msg'] ?? "Unknown error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _rollNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Roll Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: forgotPass,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: const Text('Send OTP', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PasswordReset extends StatefulWidget {
  final String rollNumber; // Add this parameter

  const PasswordReset({super.key, required this.rollNumber});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}
class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final AuthService authService=AuthService();

  void _submit() {
    String otp = _otpController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (otp.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password Reset Successful for Roll Number: ${widget.rollNumber}!")),
    );
  }
  void resetPassword()async{
    final response=await authService.resetPass(_otpController.text.trim(), _newPasswordController.text.trim(), widget.rollNumber);
    if(response.containsKey('status')&&response['status']==true){
      _submit();
      Navigator.push(context,MaterialPageRoute(builder: (context)=>SimpleLoginScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['msg']??"unknown error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Reset Password for Roll No: ${widget.rollNumber}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'Enter New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isNewPasswordVisible,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isConfirmPasswordVisible,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}