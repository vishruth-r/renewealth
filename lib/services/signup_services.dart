import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SignupService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<bool> signup(String name, String email, String password, String type, String pan, String phoneNumber) async {
    const String apiUrl = '${Constants.apiUrl}/auth/signup'; // Use the apiUrl constant

    // Get the FCM token
    String? fcmToken = await _firebaseMessaging.getToken();

    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'type': 'investor',
      'pan': pan,
      'phoneNumber': phoneNumber,
      'fcmID': fcmToken, // Include the FCM token in the request body
    };

    // Encode the request body as JSON
    String requestBody = jsonEncode(data);
    print(data);

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Store the token
        if (jsonResponse.containsKey('token')) {
          await storeToken(jsonResponse['token']);
        }

        // Check if the signup was successful based on the response
        bool signupSuccessful = true;

        // Return the signup status
        return signupSuccessful;
      } else {
        // If the request was not successful, throw an error or handle it accordingly
        throw Exception('Failed to signup: ${response.statusCode}');
      }
    } catch (error) {
      // Catch any errors that occurred during the request
      print('Error: $error');
      return false; // Return false to indicate signup failure
    }
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
