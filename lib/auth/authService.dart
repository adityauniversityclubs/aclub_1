import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl ='https://aclub.onrender.com';

Future<Map<String, dynamic>> registerUser(
    String first, String last, String roll, String phone, String pass) async {
  final res = await http.post(
    Uri.parse('$baseUrl/auth/signup'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "firstName": first,
      "lastName": last,
      "rollNo": roll,
      "phoneNo": phone,
      "password": pass
    }),
  );

  print("Response Code: ${res.statusCode}");
  print("Response Body: ${res.body}");

  return jsonDecode(res.body);
}
Future<Map<String,dynamic>>signUser(String rollNumber,String password)async{
final res=await http.post(
  Uri.parse('$baseUrl/auth/login'),
  headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "rollNo":rollNumber,
      "password":password
    }),
);
print("response code:${res.statusCode}");
print("response code:${res.body}");
return jsonDecode(res.body);
}
Future<Map<String,dynamic>>forgotPass(String roll)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/forgot-password'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":roll
     })
  );
  print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
Future<Map<String,dynamic>>resetPass(String otp,String password,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/set-forgot-password'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":rollNo,
      "otp":otp,
      "password":password
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
Future<Map<String,dynamic>>allPastEvents()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-past-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//event regestered members
Future<Map<String,dynamic>>allRegesteredStudents(String eventName)async{
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/registered-users?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//post feedback
Future<Map<String,dynamic>>giveFeedBack(String eventName,String feedback,int rating,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/registrations/give-feedback'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "eventName":eventName,
      "feedback":feedback,
      'rating':rating,
      'rollNo':rollNo
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//get feedback
Future<Map<String,dynamic>>getFeedBack(String eventName)async{
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/get-feedback?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//event regestration 
Future<Map<String,dynamic>>registerEvent(String eventName,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/registrations/register-event'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "eventName":eventName,
      'rollNo':'22a91a0571'
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//regestration status
Future<Map<String,dynamic>>regestrationStatus(String eventName,String rollNo)async{
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/registration-status?eventName=$eventName&rollNo=22a91a0571'),
    headers: {'Content-Type': 'application/json'},
 );
   print('response code:${res.statusCode}');
   print('response body:${res.body}');
   return jsonDecode(res.body);
 }
 //get all clubs data 
 Future<Map<String,dynamic>>getAllClubsData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/clubs/get-all-clubs'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
}
