
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:renewealth/views/services/ListingDetails.dart';
class CustomBoxDetails {
  final String imagePath;
  final String content;
  final String bottomContent;
  final double progress;
  final String location;
  final String apartment;
  final String endTime;
  final String id;

  CustomBoxDetails({
    required this.imagePath,
    required this.content,
    required this.bottomContent,
    required this.progress,
    required this.location,
    required this.apartment,
    required this.endTime,
    required this.id,
  });
}
class CustomBox extends StatelessWidget {
  final CustomBoxDetails details;

  CustomBox({required this.details});
  List<String> imageUrls = [
    'https://anuhar.com/blog/wp-content/uploads/2022/11/apartment-in-Hyderabad.png',
    'https://www.sobha.com/blog/wp-content/uploads/2023/07/Apartment-Complex-800x400.png',
    'https://images.adsttc.com/media/images/637c/cc4e/db20/0f35/7400/b765/newsletter/housing-apartment-at-badade-nagar-studio-frozen-music_1.jpg?1669123187',
    'https://www.realestate.com.au/news-image/w_800,h_600/v1657586179/news-lifestyle-content-assets/wp-content/production/image11.webp?_i=AA',
    'https://www.atelierarbo.com/uploads/1/1/9/4/11942319/nagaland-apartment-cover_orig.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Southmoor_Apartment_Hotel.jpg/220px-Southmoor_Apartment_Hotel.jpg',
    'https://www.redfin.com/blog/wp-content/uploads/2022/06/3337-Crocker-Dr-1.jpg'
  ];

  @override
  String getRandomImageUrl() {
    var random = Random();
    int randomIndex = random.nextInt(imageUrls.length);
    return imageUrls[randomIndex];
  }
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * 0.58, // Adjust the multiplier as needed
      height: 275.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/globe.png', // Replace with your placeholder image
                  image: getRandomImageUrl(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        details.content,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      details.bottomContent,
                      style: TextStyle(fontSize: 6, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_city, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          details.location,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.apartment, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          details.apartment,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          details.endTime,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress:',
                style: TextStyle(fontSize: 18,),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListingDetails(id: details.id)),
                  );
                },
                child: Text('Details'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 20, // Adjust this value to increase or decrease the thickness of the progress bar
                    child: LinearProgressIndicator(
                      value: details.progress,
                      color: Colors.green,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '${(details.progress * 100).toInt()}%',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}