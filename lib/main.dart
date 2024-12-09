import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hawker_food/firebase_options.dart';
import 'package:hawker_food/src/models/bag_model.dart';
import 'package:hawker_food/src/models/user_credential.dart';
import 'package:hawker_food/src/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FMTCObjectBoxBackend().initialise();

  await const FMTCStore('mapStore').manage.create();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BagModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserCredentialModel(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          home: const LoginPage(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 42, 42, 42),
              titleTextStyle: TextStyle(fontSize: 14, color: Colors.white),
              toolbarHeight: 90,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 217, 217, 217),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.black,
              backgroundColor: Colors.amber,
            ),
          ),
        );
      },
    ),
  );
}
