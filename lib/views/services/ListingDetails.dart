import 'package:flutter/material.dart';
import 'package:renewealth/views/services/CapitalDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';


class ListingDetails extends StatefulWidget {
  final String id;

  const ListingDetails({super.key, required this.id});
  @override
  _ListingDetailsState createState() => _ListingDetailsState();
}

class _ListingDetailsState extends State<ListingDetails> {
  Map<String, dynamic> data = {};
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
  void initState() {
    super.initState();
    fetchData().then((fetchedData) {
      setState(() {
        data = fetchedData;
      });
    });
  }
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse("https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/investments/${widget.id}"),
      headers: <String, String>{
        'ngrok-skip-browser-warning': '69420',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<int?> showInvestmentDialog(BuildContext context, int minInvestment) async {
    int? investmentAmount;
    final TextEditingController controller = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Investment Amount'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter amount in multiples of $minInvestment',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Invest'),
              onPressed: () {
                investmentAmount = int.tryParse(controller.text);
                if (investmentAmount != null && investmentAmount! % minInvestment == 0) {
                  Navigator.of(context).pop(investmentAmount);
                } else {
                  // Show error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid amount. It should be a multiple of $minInvestment.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
  String getRandomImageUrl() {
    var random = Random();
    int randomIndex = random.nextInt(imageUrls.length);
    return imageUrls[randomIndex];
  }
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
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/globe.png', // Replace with your placeholder image
                      image: getRandomImageUrl(),
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
                        data['description'] ?? 'Loading...', // replace 'Subscript text' with your actual subscript text
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
                    data['location'] ?? 'Loading...',
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
                    data['lastDateToInvest'] ?? 'Loading...',
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
                          value: data['investmentAmountAcquired'],
                          color: Colors.green,
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${((data['investmentAmountAcquired'] / data['investmentAmountNeeded']) * 100).toInt()}%',
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
                  List<String> secondaryTextContent = [data['investmentAmountNeeded'].toString(), data['minimumInvestment'].toString(), data['expectedReturns'] ?? 'Loading...', data['listingType'] ?? 'Loading...'];
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150, // specify the width
                    height: 50, // specify the height
                    child: ElevatedButton(
                      onPressed: () async {
                        int? investmentAmount = await showInvestmentDialog(context, data['minimumInvestment']);
                        if (investmentAmount != null) {
                          final response = await http.post(
                            Uri.parse('https://e8a2-2409-40f4-9-507f-d94f-ab52-653d-afde.ngrok-free.app/investment/invest'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'investeeId': data['investeeId'],
                              'amount': investmentAmount.toString(),
                              'investmentId': widget.id,
                            }),
                          );
                          if (response.statusCode == 200) {
                            print(response.body);
                          } else {
                            print(response.body);
                          }
                        }
                      },
                      child: Text('Invest'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    width: 150, // specify the width
                    height: 50, // specify the height
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/messages');
                      },
                      child: Text('Chat'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.green, // foreground
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}