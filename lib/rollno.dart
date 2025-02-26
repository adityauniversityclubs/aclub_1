import 'package:shared_preferences/shared_preferences.dart';
class Shared {
  static final Shared _instance = Shared._internal();

  factory Shared() {
    return _instance;
  }

  Shared._internal() {
    loadRollNo();
  }

  String rollNo = '';
  Future<void> saveRollNo(String rollNo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('rollno', rollNo);
  rollNo = rollNo;
}

  Future<void> loadRollNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rollNo = prefs.getString('rollno') ?? ''; // Load saved rollNo
  }


Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('rollno');
}
}
