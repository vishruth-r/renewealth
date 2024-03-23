import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class NewListingService {
  static const String baseUrl = 'https://2015-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app';

  static Future<bool> createNewListing({
    required String propertyName,
    required String propertyCity,
    required String propertyArea,
    required String propertyState,
    required double totalInvestment,
    required double investmentProcured,
    required double returnsPerYear,
    required double minimumInvestment,
    required String lastDate,

  }) async {
    try {
      // Print the request body before sending the request
      final requestBody = <String, dynamic>
      {
        "location": propertyCity+', '+propertyState,
        "investmentAmountNeeded": totalInvestment,
        "investmentAmountAcquired": investmentProcured,
        "expectedReturns": returnsPerYear.toString()+"% pa",
        "minimumInvestment": minimumInvestment,
        "listingType": "Public",
        "description": propertyName,
        "imageURL": "image",
        "lastDateToInvest": '2022-01-01',

      }
      ;
      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('$baseUrl/investment/createInvestment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwNjRkMmEzMi1mYjI1LTQ3NWYtYmNjOC00MDJiMWQ3ODI1NmYiLCJpYXQiOjE3MTA2MjIyMzJ9.-4HrJ-gAowIBCRd3GvtD0ZWo1GECV6lixnumo8t1Ku4',
        },
        body: jsonEncode(requestBody),
      );


      if (response.statusCode == 200) {
        // Listing created successfully
        print('Response Body: ${response.body}');
        return true;
      } else {
        // Handle errors here, e.g., log or show error message
        print('Error: ${response.statusCode}, Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions here, e.g., log or show error message
      print('Exception: $e');
      return false;
    }
  }
}
