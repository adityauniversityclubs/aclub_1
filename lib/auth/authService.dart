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
//verify Otp
Future<Map<String,dynamic>>verifyOtp(String otp,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/verify-otp'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":rollNo,
      "otp":otp,
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

Future<Map<String,dynamic>>resetPass(String password,String rollNo)async{
  final res=await http.post(
    Uri.parse('$baseUrl/auth/set-forgot-password'),
     headers: {'Content-Type': 'application/json'},
     body: jsonEncode({
      "rollNo":rollNo,
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
  // print(eventName);
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    
    Uri.parse('$baseUrl/registrations/registered-users?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');

  // return jsonDecode(eventName);
  return jsonDecode(res.body);
}
//post feedback
Future<Map<String,dynamic>>giveFeedBack(String eventName,String feedback,int rating,String rollNo)async{
  
  // eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");

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
  print('${eventName}');
  return jsonDecode(res.body);
}
//get feedback
Future<Map<String,dynamic>>getFeedBack(String eventName)async{
  
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
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
      'rollNo':rollNo
     })
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//regestration status
Future<Map<String,dynamic>>regestrationStatus(String eventName,String rollNo)async{

  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    Uri.parse('$baseUrl/registrations/registration-status?eventName=$eventName&rollNo=$rollNo'),
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

//get live events
 Future<Map<String,dynamic>>getLiveData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/ongoing-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//get Live upcoming data
 Future<Map<String,dynamic>>getupComingData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/upcoming-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//get past events
 Future<Map<String,dynamic>>getPastData(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/past-events?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
 Future<Map<String,dynamic>>getEventDetailsByName(String eventName)async{
  eventName = Uri.encodeComponent(eventName).replaceAll("+", "%20");
  final res=await http.get(
    Uri.parse('$baseUrl/events/get-event-details?eventName=$eventName'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}, , eventname : ${eventName}');
  return jsonDecode(res.body);
}


//get all live events
 Future<Map<String,dynamic>>getAllLiveData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-ongoing-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
//get all Live upcoming data
 Future<Map<String,dynamic>>getAllupComingData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-upcoming-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//get all past events
 Future<Map<String,dynamic>>getAllPastData()async{
  final res=await http.get(
    Uri.parse('$baseUrl/events/all-past-events'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}

//getAllClubMembers
 Future<Map<String,dynamic>>getAllClubMembers(String clubId)async{
  final res=await http.get(
    Uri.parse('$baseUrl/participation/get-club-members?clubId=$clubId'),
     headers: {'Content-Type': 'application/json'},
  );
   print('response code:${res.statusCode}');
  print('response body:${res.body}');
  return jsonDecode(res.body);
}
}
