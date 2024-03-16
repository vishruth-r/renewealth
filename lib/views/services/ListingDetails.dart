import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CapitalDetails.dart';

class ListingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Active Listings'), // replace 'Title' with your actual title
      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0), // Add margins to the entire column
          child: Column(
            children: [
              // First row with image
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Add this
                children: [
                  Container(
                    width: deviceWidth * 0.8, // Adjust the multiplier as needed
                    height: deviceHeight * 0.25, // Adjust the multiplier as needed
                    child: Image.network(
                      'assets/images/apartment2.webp', // replace with your actual image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add this
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Solar Panel Investment', // replace 'Subheading' with your actual subheading
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Subscript text', // replace 'Subscript text' with your actual subscript text
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10), // Add this
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description', // replace 'Subheading' with your actual subheading
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'text', // replace 'Subscript text' with your actual subscript text
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10), // Add this
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
                    'Green Valley Apartments',
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
              SizedBox(height: 10), // Add this
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Investment:',
                    style: TextStyle(fontSize: 18,),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CapitalDetails()),
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
                          value: 0.65,
                          color: Colors.green,
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${(0.65 * 100).toInt()}%',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3/2, // Adjust this value to change the grid height
                children: List.generate(4, (index) {
                  // List of text content for each grid
                  List<String> textContent = ['Price per unit', 'Min Investment', 'Annual Return', 'Listing Type'];
                  // List of secondary text content for each grid
                  List<String> secondaryTextContent = ['500', '100000', '12%', 'Solar'];

                  return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          textContent[index], // Get the text content for this grid
                          style: TextStyle(fontSize: 14,color: Colors.grey),
                        ),
                        Text(
                          secondaryTextContent[index], // Get the secondary text content for this grid
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}