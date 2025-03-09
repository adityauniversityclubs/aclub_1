import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static final Shared _instance = Shared._internal();

  factory Shared() {
    return _instance;
  }

  Shared._internal();

  String rollNo = '';
  String token = '';
   String clubId='';
   bool isAdmin=false;
  /// Initialize the stored values asynchronously
  Future<void> init() async {
    await loadRollNo();
    await loadToken();
    await loadclubIdAndIsAdmin();
  }
    Future<void> saveclubId(String clubId, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('clubId', clubId);
    await prefs.setBool('isAdmin', isAdmin);
   
    this.clubId=clubId;
    this.isAdmin=isAdmin; // Correctly update the instance variable
  }

  Future<void> saveRollNo(String rollNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rollno', rollNo);
    this.rollNo = rollNo; // Correctly update the instance variable
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    this.token = token; // Correctly update the instance variable
  }
   Future<void> loadclubIdAndIsAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clubId=prefs.getString('clubId')??'';
    isAdmin=prefs.getBool('isAdmin')??false; // Load saved token
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? ''; // Load saved token
  }

  Future<void> loadRollNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rollNo = prefs.getString('rollno') ?? ''; // Load saved rollNo
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('rollno');
    await prefs.remove('token'); // Also remove the token
    rollNo = '';
    token = '';
    clubId='';
    isAdmin=false;
  }
}
