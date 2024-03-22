import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
class CapitalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<InvestorData> data = [
      InvestorData('Tata Power', 20.5),
      InvestorData('Adani Solar', 12.4),
      InvestorData('JSW Energy', 10.5),
      InvestorData('Anil Kumar', 8.2),
      InvestorData('Sequoia Capital', 7.8),
      // Add more InvestorData objects as needed
    ];
    Map<String, double> dataMap = {
      'Tata Power': 20.5,
      'Adani Solar': 12.4,
      'JSW Energy': 10.5,
      'Anil Kumar': 8.2,
      'Sequoia Capital': 7.8,
      'Promoters': 40.6,

    };

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
                        "assets/images/apartment1.webp",
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
                              "Solar Panel Investment",
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
                            DataCell(Text('Tata Power')),
                            DataCell(Text('20.5%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Adani Solar')),
                            DataCell(Text('12.4%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('JSW Energy')),
                            DataCell(Text('10.5%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Anil Kumar')),
                            DataCell(Text('8.2%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Sequoia Capital')),
                            DataCell(Text('7.8%')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Promoters')),
                            DataCell(Text('40.6%')),
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
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          centerText: "HYBRID",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        )
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
  final double allocation;

  InvestorData(this.investor, this.allocation);
}