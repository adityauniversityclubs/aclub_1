import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<dynamic> _eventList = [];

  List<dynamic> get eventList => _eventList;

  void updateEventList(List<dynamic> newList) {
    _eventList = newList;
    notifyListeners(); // Notify listeners to rebuild UI
  }
}
