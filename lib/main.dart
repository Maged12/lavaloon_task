import 'package:flutter/material.dart';
import 'Home/providers/movies_provider.dart';
import 'Home/providers/watchList_provider.dart';
import 'Home/screens/home_screen.dart';
import 'auth_feature/providers/auth_provider.dart';
import 'auth_feature/providers/user_provider.dart';

import 'auth_feature/screens/login_screen.dart';
import 'core/constants/global.dart';
import 'core/constants/strings.dart';
import 'shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.prefs = SharedPrefs(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => WatchListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LavaLoon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Global.prefs.getInt(Strings.userIdKey) != 0
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}
