import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:renewealth/views/screens/login_page.dart';
import 'package:renewealth/views/screens/messages_page.dart';
import 'package:renewealth/views/screens/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


void main() async {
  // Ensure that Firebase is initialized before runApp() is called
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  // Check if a token exists in shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  // Determine initial route based on token existence
  String initialRoute = token != null ? '/messages' : '/';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primaryColor: createMaterialColor(const Color(0xFF65B741)),
        primarySwatch: createMaterialColor(const Color(0xFF65B741)),
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/messages': (context) => const MessagesPage(),
      },
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {}; // Declare swatch as Map<int, Color>
    final int r = color.red,
        g = color.green,
        b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
