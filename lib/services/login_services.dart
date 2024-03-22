import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../constants.dart';

class LoginService {
  Future<bool> login(String email, String password) async {

    final String? fcmToken = await getFcmToken();
    const String apiUrl = '${Constants.apiUrl}/auth/login'; // Use the apiUrl constant

    // Prepare the request body
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'fcmID': fcmToken,
    };
    print('$fcmToken');

    // Encode the request body as JSON
    String requestBody = jsonEncode(data);

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
        print("works");
        // If the response is successful, parse the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('token') && jsonResponse.containsKey('person')) {
          await storeToken(jsonResponse['token'], jsonResponse['person']['id']);
        }

        // Check if the login was successful based on the response
        bool loginSuccessful = true;

        // Return the login status
        return loginSuccessful;
      } else {
        print("doesnt work");
        // If the request was not successful, throw an error or handle it accordingly
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (error) {
      // Catch any errors that occurred during the request
      print('Error: $error');
      return false; // Return false to indicate login failure
    }
  }
  Future<void> storeToken(String token, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('person_id', id);
    print(token);
    print(id);
  }
  Future<String?> getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token;
  }
}