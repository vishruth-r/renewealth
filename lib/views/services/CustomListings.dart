
import 'package:flutter/material.dart';
import 'package:renewealth/views/services/ListingDetails.dart';
class CustomBox extends StatelessWidget {
  final String imagePath;
  final String content;
  final String bottomContent;
  final double progress;

  CustomBox({required this.imagePath, required this.content, required this.bottomContent,  required this.progress, });

  @override
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
                child: Image.asset(
                  imagePath,
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
                        content,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      bottomContent,
                      style: TextStyle(fontSize: 6, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_city, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          'Mumbai, Maharashtra',
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
                          'Green Valley Apartements',
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
                          'Ending in 5 days',
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
                    MaterialPageRoute(builder: (context) => ListingDetails()),
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
                      value: progress,
                      color: Colors.green,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '${(progress * 100).toInt()}%',
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