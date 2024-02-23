import 'package:flutter/material.dart';
import 'package:renewealth/views/screens/home_page.dart';
import 'package:renewealth/views/screens/listings.dart';
import 'package:renewealth/views/screens/login_page.dart';
import 'package:renewealth/views/screens/messages_page.dart';
import 'package:renewealth/views/screens/signup_page.dart';
import 'package:renewealth/views/services/navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primaryColor: createMaterialColor(Color(0xFF65B741)),
        primarySwatch: createMaterialColor(Color(0xFF65B741)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/messages': (context) => MessagesPage(),
        '/home_page' : (context)  => HomePage(),
        '/navbar' : (context) => Scaffold(
          bottomNavigationBar: NavBar(
            currentIndex: 1,
            onTap: (index) {
              Navigator.pushNamed(context, '/${index+1}');
            },
          ),
        ),
        '/1': (context) => HomePage(),
        '/2': (context) => ListingPage(),
        '/3': (context) => MessagesPage(),
        '/4': (context) => MessagesPage(),
      },
      debugShowCheckedModeBanner: false,
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
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}