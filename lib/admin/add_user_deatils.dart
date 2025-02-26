import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? selectedRole;

  final List<String> roles = ['Club Lead', 'Coordinator', 'Members'];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Color(0xFF040737),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              _buildTextField('First Name', firstNameController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Last Name', lastNameController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Roll Number', rollNumberController),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField('Phone Number', phoneNumberController, isPhone: true),
              SizedBox(height: screenHeight * 0.02),
              _buildDropdown('Select Role'),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                onPressed: _submitDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF040737),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.016,
                    horizontal: screenWidth * 0.3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  void _submitDetails() {
    print('First Name: ${firstNameController.text}');
    print('Last Name: ${lastNameController.text}');
    print('Roll Number: ${rollNumberController.text}');
    print('Phone Number: ${phoneNumberController.text}');
    print('Role: ${selectedRole ?? 'No role selected'}');
  }
}
