// import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'dart:io';


// class EventCreation extends StatefulWidget {
//   @override
//   _EventCreationState createState() => _EventCreationState();
// }

// class _EventCreationState extends State<EventCreation> {
//   final TextEditingController eventNameController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController timeController = TextEditingController();
//   final TextEditingController guestController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController mainThemeController = TextEditingController();
//   final TextEditingController detailsController = TextEditingController();
//   File? _selectedImage;
//   bool _imageSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Event Creation',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: Color(0xFF040737),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: screenHeight * 0.02),
//               _buildTextField('Event Name', eventNameController),
//               _buildTextField('Guest', guestController),
//               _buildTextField('Location', locationController),
//               _buildTextField('Main Theme', mainThemeController),
//               _buildTextField('Details', detailsController),
//               Row(
//                 children: [
//                   Expanded(child: _buildDatePicker('Date', dateController)),
//                   SizedBox(width: screenWidth / 18),
//                   Expanded(child: _buildTimePicker('Time', timeController)),
//                 ],
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               _buildImagePicker(screenHeight, screenWidth),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 onPressed: _submitDetails,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF040737),
//                   padding: EdgeInsets.symmetric(
//                     vertical: screenHeight * 0.016,
//                     horizontal: screenWidth * 0.37,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: Text(
//                   'Submit',
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(color: Color(0xFF040737), width: 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDatePicker(String label, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFF040737), width: 1),
//         ),
//         suffixIcon: Icon(Icons.calendar_month, color: Color(0xFF040737)),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );
//         if (pickedDate != null) {
//           setState(() {
//             controller.text = "${pickedDate.toLocal()}".split(' ')[0];
//           });
//         }
//       },
//     );
//   }

//   Widget _buildTimePicker(String label, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(color: Color(0xFF040737), width: 1),
//         ),
//         suffixIcon: Icon(Icons.timer, color: Color(0xFF040737)),
//       ),
//       onTap: () async {
//         TimeOfDay? pickedTime = await showTimePicker(
//           context: context,
//           initialTime: TimeOfDay.now(),
//         );
//         if (pickedTime != null) {
//           setState(() {
//             controller.text = pickedTime.format(context);
//           });
//         }
//       },
//     );
//   }

//   Widget _buildImagePicker(double screenHeight, double screenWidth) {
//     double containerHeight = _imageSelected ? screenHeight * 0.2 : screenHeight*0.06;
//     double containerWidth = _imageSelected ? screenWidth : screenWidth*0.9;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: GestureDetector(
//         onTap: _pickImage,
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           height: containerHeight,
//           width: containerWidth,
//           decoration: BoxDecoration(
//             border: Border.all(color: Color(0xFF040737), width: 1),
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//           ),
//           child: _selectedImage != null
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.file(
//               _selectedImage!,
//               width: double.infinity,
//               height: containerHeight,
//               fit: BoxFit.cover,
//             ),
//           )
//               : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Tap to select an image',
//                 style: TextStyle(color: Color(0xFF040737)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//         _imageSelected = true;
//       });
//     }
//   }

//   void _submitDetails() {
//     print('Event Name: ${eventNameController.text}');
//     print('Guest: ${guestController.text}');
//     print('Location: ${locationController.text}');
//     print('Main Theme: ${mainThemeController.text}');
//     print('Details: ${detailsController.text}');
//     print('Date: ${dateController.text}');
//     print('Time: ${timeController.text}');
//     print('Image: ${_selectedImage?.path ?? 'No image selected'}');
//   }

//   @override
//   void dispose() {
//     eventNameController.dispose();
//     guestController.dispose();
//     locationController.dispose();
//     mainThemeController.dispose();
//     detailsController.dispose();
//     dateController.dispose();
//     timeController.dispose();
//     super.dispose();
//   }
// }
