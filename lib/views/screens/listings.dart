import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CustomListings.dart';
import 'package:renewealth/views/services/navbar.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  String selectedButton = 'Active';

  @override
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
              itemCount: 3, // replace with your actual list length
              itemBuilder: (context, index) {
                return CustomBox(
                  imagePath: 'assets/images/apartment${index+1}.webp', // replace with your actual image paths
                  content: 'Solar Panel Investment', // replace with your actual content
                  bottomContent: 'ID',
                  progress: 0.65,// replace with your actual bottom content
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