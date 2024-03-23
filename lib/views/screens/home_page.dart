import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CustomListings.dart';
import 'package:renewealth/views/services/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> listings = [];
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterList);
    _fetchData();
  }

  void _filterList() {
    setState(() {
      if (_searchController.text.isEmpty) {
        // If the search text is empty, show all listings
        listings = List.from(listings);
      } else {
        // If the search text is not empty, show only the listings where the investeeName contains the search text
        listings = listings
            .where((listing) => listing['investeeName'].toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }
  Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse("https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/investments"),
      headers: <String, String>{
        'ngrok-skip-browser-warning': '69420',
      },
    );
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // if (response.headers['content-type'] != 'application/json') {
      //   throw Exception('Received non-JSON response');
      // }
      setState(() {
        listings = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 50.0),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF59BD8B), Color(0xFFB1EA54), Color(0xFFA9E14D)],
                ).createShader(bounds),
                child: Text(
                  'ReneWealth',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFCCCCCC), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFCCCCCC), width: 2),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20.0),
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
      ),
      bottomNavigationBar: NavBar(
        currentIndex: 0,
        onTap: (index) {
          Navigator.pushNamed(context, '/${index+1}');
        },
      ),
    );
  }

  Widget _buildContainer(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        // Handle container tap
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 100,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.64, 0.53),
            radius: 0.17,
            colors: [Color(0xFF59BD8B), Color(0xFFB1EA54), Color(0xFFA9E14D)],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Satoshi Variable',
            fontWeight: FontWeight.w900,
            height: 0.07,
            letterSpacing: -0.50,
          ),
        ),
      ),
    );
  }
}