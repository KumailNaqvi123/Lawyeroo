import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/HomescreenLawyerDetailsPage.dart';

class HomescreenReccLawyers extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData; // Add this line

  HomescreenReccLawyers({required this.token, required this.userData}); // Modify constructor

  @override
  _HomescreenReccLawyers createState() => _HomescreenReccLawyers();
}

class _HomescreenReccLawyers extends State<HomescreenReccLawyers> {
  List<Map<String, dynamic>> lawyerProfiles = [];
  List<Map<String, dynamic>> filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchLawyersData();
    print("Current Page: HomescreenReccLawyers.dart");
  }

 Future<void> fetchLawyersData() async {
  try {
    final response = await http.get(
     Uri.parse('https://3c74-154-81-228-94.ngrok-free.app/recommendations?client_id=${widget.userData['id']}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      // Extract data from the correct key
      final data = jsonDecode(response.body);
      final List<dynamic> lawyerData = data['recommended_lawyers'] as List;

      setState(() {
        lawyerProfiles = lawyerData.map((lawyer) => {
          'lawyer_id': lawyer['lawyer_id'],
          'name': '${lawyer['first_name']} ${lawyer['last_name']}',
          'specialization': lawyer['specializations'][0], // Access the first specialization
          'rating': double.parse(lawyer['rating'].toString()),
          'image': lawyer['profile_picture'],
          'email': lawyer['email'],
          'address': lawyer['address'],
          'fees': lawyer['fees'],
          'verified': lawyer['verified'],
          'ph_number': lawyer['ph_number'],
          'years_of_experience': lawyer['years_of_experience'],
          'universities': lawyer['universities']
        }).toList();
        filteredProfiles = List.from(lawyerProfiles); // Assuming you use this for search or filtering
      });

      print('Fetched Lawyer Data:');
      print(lawyerProfiles);
    } else {
      print('${GlobalData().baseUrl}');
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Recommended Lawyers',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: lawyerProfiles.length,
                    itemBuilder: (context, index) {
                      double rating = lawyerProfiles[index]['rating'];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                          vertical: constraints.maxWidth * 0.03,
                        ),
                        child: IntrinsicHeight(
                              child: ElevatedButton(
                              onPressed: () {
                                // Data to be passed
                                Map<String, dynamic> lawyerData = {
                                  'lawyer_id': lawyerProfiles[index]['lawyer_id'],
                                  'first_name': lawyerProfiles[index]['name'].split(" ")[0],
                                  'last_name': lawyerProfiles[index]['name'].split(" ").length > 1 ? lawyerProfiles[index]['name'].split(" ")[1] : "",
                                  'profile_picture': lawyerProfiles[index]['image'],
                                  'specializations': jsonEncode([lawyerProfiles[index]['specialization']]),
                                  'rating': lawyerProfiles[index]['rating'].toString(),
                                  'address': lawyerProfiles[index]['address'],
                                  'email': lawyerProfiles[index]['email'],
                                  'fees': lawyerProfiles[index]['fees'],
                                  'ph_number': lawyerProfiles[index]['ph_number'],
                                  'universities': lawyerProfiles[index]['universities'],
                                  'verified': lawyerProfiles[index]['verified'],
                                  'years_of_experience': lawyerProfiles[index]['years_of_experience'],
                                  'rating_count': lawyerProfiles[index]['rating_count']
                                };
                                
                                // Print the data being passed
                                    print('Navigating to Details Page with data:');
                                    print(jsonEncode(lawyerData));  // This will print all the data being passed as JSON

                                // Navigate to the Lawyer Details page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomescreenLawyerDetailsScreen(
                                      token: widget.token,
                                      userData: widget.userData,
                                      lawyerData: lawyerData,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(lawyerProfiles[index]['image']),
                                    radius: constraints.maxWidth * 0.1,
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.03),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lawyerProfiles[index]['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxWidth * 0.05, // Adjusted font size
                                        ),
                                      ),
                                      Text(
                                        lawyerProfiles[index]['specialization'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: constraints.maxWidth * 0.035, // Adjusted font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: constraints.maxWidth * 0.06,
                                          ),
                                          Text(
                                            rating.toStringAsFixed(1),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: constraints.maxWidth * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
