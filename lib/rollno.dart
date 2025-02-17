class Shared {
  static final Shared _instance = Shared._internal();

  factory Shared() {
    return _instance;
  }

  Shared._internal();

  String rollNo = '';
}
