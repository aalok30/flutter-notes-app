
import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/core/locator.dart';
import 'package:hive/hive.dart';


class AppDB {
  static const _appDbBox = '_appDbBox';
  static const fcmKey = 'fcm_key';
  static const platform = 'platform';
  final Box<dynamic> _box;
  final ValueNotifier<bool> isConnectedToHealthAppNotifier;

  AppDB._(this._box)
      : isConnectedToHealthAppNotifier = ValueNotifier<bool>(_box.get("isConnectedToHealthApp", defaultValue: false));

  static Future<AppDB> getInstance() async {
    final box = await Hive.openBox<dynamic>(_appDbBox);
    final db = AppDB._(box);

    // Listen for changes and update Hive automatically
    db.isConnectedToHealthAppNotifier.addListener(() {
      debugPrint("is connected to health apps");
      db.setValue("isConnectedToHealthApp", db.isConnectedToHealthAppNotifier.value);
    });

    return db;
  }

  T getValue<T>(String key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  ///for set/get biometric
  bool get enableBiometric => getValue("enableBiometric", defaultValue: false);
  set enableBiometric(bool update) => setValue("enableBiometric", update);

  ///for set/get login
  bool get isLogin => getValue("isLogin", defaultValue: false);
  set isLogin(bool update) => setValue("isLogin", update);

  ///for set/get walkthrough visited
  bool get isFirstTime => getValue("isFirstTime", defaultValue: true);
  set isFirstTime(bool update) => setValue("isFirstTime", update);

  ///for get complete profile
  bool get isCompleteProfile => getValue("isCompleteProfile", defaultValue: true);
  set isCompleteProfile(bool update) => setValue("isCompleteProfile", update);

  ///for get complete profile
  bool get isGuestUser => getValue("isGuestUser", defaultValue: false);
  set isGuestUser(bool update) => setValue("isGuestUser", update);

  ///for set/get is connected to healthApps
  bool get isConnectedToHealthApp => isConnectedToHealthAppNotifier.value;
  set isConnectedToHealthApp(bool update) => isConnectedToHealthAppNotifier.value = update;

  String get apiKey =>
      getValue("apiKey", defaultValue: "YKoGcMbFZwUFJf0LF7UUXEG91LDuEmNFLRn14vKNupVdciQXs2XthzSyF77TQPbz");

  set apiKey(String update) => setValue("apiKey", update);

  String get token => getValue("token", defaultValue: "");

  set token(String update) => setValue("token", update);

  String get fcmToken => getValue("fcm_token", defaultValue: "0");

  set fcmToken(String update) => setValue("fcm_token", update);

  // String get defaultServer => getValue("defaultServer", defaultValue: APIEndPoints.environment.name);
  //
  // set defaultServer(String update) => setValue("defaultServer", update);

  // UserData? get user => getValue("user");
  //
  // set user(UserData? user) => setValue("user", user);

  String get deviceuuid => getValue("deviceuuid", defaultValue: "");

  set deviceuuid(String deviceuuid) => setValue("deviceuuid", deviceuuid);

  String get deviceapilvl => getValue('deviceapilvl', defaultValue: "");

  set deviceapilvl(String deviceapilvl) => setValue("deviceapilvl", deviceapilvl);

  String get devicedetails => getValue('devicedetails', defaultValue: "");

  set devicedetails(String devicedetails) => setValue("devicedetails", devicedetails);

  String get deviceIp => getValue('deviceIp', defaultValue: "");

  set deviceIp(String deviceIp) => setValue("deviceIp", deviceIp);



  void logout() {
    token = "";

    isLogin = false;
    enableBiometric = false;
  }
}

final appDB = locator<AppDB>();
