import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class CapitalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<InvestorData> data = [
      InvestorData('Investor 1', 20),
      InvestorData('Investor 2', 30),
      InvestorData('Investor 3', 50),
      // Add more InvestorData objects as needed
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Capital Details'), // replace 'Title' with your actual title
      ),
      body: SingleChildScrollView(
        child:Container(
          margin: EdgeInsets.all(20.0), // Add margins to the entire column
          child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/images/globe.png",
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
                              "Title",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            "ID",
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add this
                Column(
                  children: [
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
                    // New row for '0' text
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '80lacs',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    // New row for '80lacs' text
                  ],
                ),
                SizedBox(height: 20), // Add this
                Row(
                  children: [
                    Text(
                      'Fund Holdings', // replace 'Subheading' with your actual subheading
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10), // Add this
                Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Investor')),
                          DataColumn(label: Text('Allocation')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Investor 1')),
                            DataCell(Text('20%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Investor 2')),
                            DataCell(Text('30%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Investor 3')),
                            DataCell(Text('50%')),
                          ]),
                          // Add more DataRows as needed
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Pie Chart', // replace 'Subheading' with your actual subheading
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),// Add this
                // SizedBox(height: 10), // Add this
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        child: charts.PieChart(
                          [
                            charts.Series<InvestorData, String>(
                              id: 'Investors',
                              domainFn: (InvestorData investors, _) => investors.investor,
                              measureFn: (InvestorData investors, _) => investors.allocation,
                              data: data,
                              colorFn: (InvestorData investors, _) {
                                switch (investors.investor) {
                                  case 'Investor 1':
                                    return charts.MaterialPalette.blue.shadeDefault;
                                  case 'Investor 2':
                                    return charts.MaterialPalette.red.shadeDefault;
                                  case 'Investor 3':
                                    return charts.MaterialPalette.green.shadeDefault;
                                  default:
                                    return charts.MaterialPalette.gray.shadeDefault;
                                }
                              },
                            )
                          ],
                          animate: true,
                          defaultRenderer: charts.ArcRendererConfig(arcWidth: 60),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class InvestorData {
  final String investor;
  final int allocation;

  InvestorData(this.investor, this.allocation);
}