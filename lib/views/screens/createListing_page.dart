import 'package:flutter/material.dart';
import 'package:renewealth/views/screens/home_page.dart';

import '../services/newlisting_service.dart';

void main() {
  runApp(MaterialApp(
    home: PropertyDetailsPage(),
  ));
}

class PropertyDetailsPage extends StatefulWidget {
  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _propertyName;
  String? _propertyCity;
  String? _propertyArea;
  String? _propertyState;
  double? _totalInvestment;
  double? _investmentProcured;
  double? _returnsPerYear;

    List<String> _propertyStates = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jammu and Kashmir",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttar Pradesh",
      "Uttarakhand",
      "West Bengal"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Property Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the property name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _propertyName = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the property city';
                  }
                  return null;
                },
                onSaved: (value) {
                  _propertyCity = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Area'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the property area';
                  }
                  return null;
                },
                onSaved: (value) {
                  _propertyArea = value;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Property State'),
                items: _propertyStates.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _propertyState = value.toString();
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a property state';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Total Investment Needed'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the total investment needed';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalInvestment = double.tryParse(value!) ?? 0.0;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Investment Already Procured'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the investment already procured';
                  }
                  return null;
                },
                onSaved: (value) {
                  _investmentProcured = double.tryParse(value!) ?? 0.0;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Returns Per Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the returns per year';
                  }
                  return null;
                },
                onSaved: (value) {
                  _returnsPerYear = double.tryParse(value!) ?? 0.0;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyPicturesPage(
                          propertyName: _propertyName,
                          propertyCity: _propertyCity,
                          propertyArea: _propertyArea,
                          propertyState: _propertyState,
                          totalInvestment: _totalInvestment,
                          investmentProcured: _investmentProcured,
                          returnsPerYear: _returnsPerYear,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyPicturesPage extends StatefulWidget {
  final String? propertyName;
  final String? propertyCity;
  final String? propertyArea;
  final String? propertyState;
  final double? totalInvestment;
  final double? investmentProcured;
  final double? returnsPerYear;

  PropertyPicturesPage({
    this.propertyName,
    this.propertyCity,
    this.propertyArea,
    this.propertyState,
    this.totalInvestment,
    this.investmentProcured,
    this.returnsPerYear,
  });

  @override
  _PropertyPicturesPageState createState() => _PropertyPicturesPageState();
}

  class _PropertyPicturesPageState extends State<PropertyPicturesPage> {
    List<String> _propertyImages = ['', '', ''];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Upload Property Pictures'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Upload Property Pictures:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: _buildImagePicker(0),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildImagePicker(1),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildImagePicker(2),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalDetailsPage(
                        propertyName: widget.propertyName,
                        propertyCity: widget.propertyCity,
                        propertyArea: widget.propertyArea,
                        propertyState: widget.propertyState,
                        totalInvestment: widget.totalInvestment,
                        investmentProcured: widget.investmentProcured,
                        returnsPerYear: widget.returnsPerYear,
                        propertyImages: _propertyImages,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildImagePicker(int index) {
      return InkWell(
        onTap: () {
          // Implement image upload functionality here
        },
        child: Container(
          height: 100,
          color: Colors.grey[200],
          child: Center(
            child: _propertyImages[index] != ''
                ? Image.network(_propertyImages[index])
                : Icon(Icons.add_a_photo),
          ),
        ),
      );
    }
  }


class PersonalDetailsPage extends StatefulWidget {
  final String? propertyName;
  final String? propertyCity;
  final String? propertyArea;
  final String? propertyState;
  final double? totalInvestment;
  final double? investmentProcured;
  final double? returnsPerYear;
  final List<String>? propertyImages;

  PersonalDetailsPage({
    this.propertyName,
    this.propertyCity,
    this.propertyArea,
    this.propertyState,
    this.totalInvestment,
    this.investmentProcured,
    this.returnsPerYear,
    this.propertyImages,
  });

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _yourName;
  String? _accountDetails;
  double? _minimumInvestment;
  String? _lastDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Personal Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _yourName = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Account Details'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your account details';
                  }
                  return null;
                },
                onSaved: (value) {
                  _accountDetails = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Minimum Investment'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the minimum investment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _minimumInvestment = double.tryParse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the last date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastDate = value;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    bool success = await NewListingService.createNewListing(
                      propertyName: widget.propertyName!,
                      propertyCity: widget.propertyCity!,
                      propertyArea: widget.propertyArea!,
                      propertyState: widget.propertyState!,
                      totalInvestment: widget.totalInvestment!,
                      investmentProcured: widget.investmentProcured!,
                      returnsPerYear: widget.returnsPerYear!,
                      minimumInvestment: _minimumInvestment!,
                      lastDate: _lastDate!.toString(),
                    );

                    if (success) {
                      // Listing created successfully, do something, e.g., navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      // Show an error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to create listing. Please try again.'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
