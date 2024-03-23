import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CustomListings.dart';
import 'package:renewealth/views/services/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  String selectedButton = 'Active';
  List<Map<String, dynamic>> listings = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse("https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/investments"),
      headers: <String, String>{
        'ngrok-skip-browser-warning': '69420',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        listings = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80.0),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('Active'),
                  style: TextButton.styleFrom(
                    foregroundColor: selectedButton == 'Active' ? Colors.green : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedButton = 'Active';
                    });
                  },
                ),
                TextButton(
                  child: Text('Scheduled'),
                  style: TextButton.styleFrom(
                    foregroundColor: selectedButton == 'Scheduled' ? Colors.green : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedButton = 'Scheduled';
                    });
                  },
                ),
                TextButton(
                  child: Text('Past'),
                  style: TextButton.styleFrom(
                    foregroundColor: selectedButton == 'Past' ? Colors.green : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedButton = 'Past';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return CustomBox(
                  details: CustomBoxDetails(
                    imagePath: listings[index]['imageURL'],
                    content: listings[index]['investeeName'],
                    bottomContent: listings[index]['description'],
                    progress: listings[index]['investmentAmountAcquired'] / listings[index]['investmentAmountNeeded'],
                    location: listings[index]['location'],
                    apartment: listings[index]['investeeId'],
                    endTime: listings[index]['lastDateToInvest'],
                    id: listings[index]['id'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: 1,
        onTap: (index) {
          Navigator.pushNamed(context, '/${index+1}');
        },
      ),
    );
  }
}