import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CustomListings.dart';
import 'package:renewealth/views/services/navbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(5.0),
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
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // replace with your actual list length
                itemBuilder: (context, index) {
                  return CustomBox(
                    imagePath: 'assets/images/globe.png', // replace with your actual image paths
                    content: 'Solar Panel Investment', // replace with your actual content
                    bottomContent: 'ID',
                    progress: 0.65,// replace with your actual bottom content
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