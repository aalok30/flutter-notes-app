import 'dart:io';

import 'package:flutter_note_app/core/app_db.dart';
import 'package:flutter_note_app/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';


import 'package:path_provider/path_provider.dart';



GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// setup hive
  final appDocumentDir = Platform.isAndroid ? await getApplicationDocumentsDirectory() : await getLibraryDirectory();

  Hive..init(appDocumentDir.path);

  locator.registerSingletonAsync<AppDB>(() => AppDB.getInstance());

  // Register AppRouter for navigation
  locator.registerLazySingleton<AppRouter>(() => AppRouter());

  // register stores if only you requires singleton
  //locator.registerLazySingleton<SignUpStore>(() => SignUpStore());
}
