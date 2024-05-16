import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/HomescreenLawyerDetailsPage.dart';

class SearchPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  SearchPage({required this.token, required this.userData});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> lawyerProfiles = [];
  TextEditingController searchController = TextEditingController();

  Future<void> fetchLawyersData({String keyword = ''}) async {
    var queryParams = {
      'keyword': keyword,
    };

    try {
      // Construct URI components
      var baseUrl = GlobalData().baseUrl;
      var host = Uri.parse(baseUrl).host;
      var path = '/api/lawyers';
    
      // Construct the URI
      Uri uri = Uri(
        scheme: 'http',
        host: host,
        port: 3000, // Assuming your server is running on port 3000
        path: path,
        queryParameters: queryParams,
      );

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          lawyerProfiles = responseData.map<Map<String, dynamic>>((lawyer) {
            // Ensure specializations is stored as a List<dynamic>
            List<dynamic> specializations = [];
            if (lawyer['specializations'] != null && lawyer['specializations'] is List) {
              specializations = List<dynamic>.from(lawyer['specializations']);
            }
            Map<String, dynamic> mappedLawyer = {
              ...lawyer,
              'lawyer_id': lawyer['id'],
              'name': '${lawyer['first_name']} ${lawyer['last_name']}',
              'specializations': specializations, // Store specializations as a List<dynamic>
              'rating': double.tryParse(lawyer['rating'].toString()) ?? 0.0,
              'image': lawyer['profile_picture'] ?? 'default_image_path',
            };

            // Print lawyer with details and types
            mappedLawyer.forEach((key, value) {
              print('$key: $value (${value.runtimeType})');
            });

            return mappedLawyer;
          }).toList();
        });
      } else {
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
        title: Center(child: Text('Search', style: TextStyle(color: Color(0xff30417c)))),
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Search for lawyers',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        onPressed: () => fetchLawyersData(keyword: searchController.text),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lawyerProfiles.length,
                    itemBuilder: (context, index) {
                      var profile = lawyerProfiles[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profile['image'] ?? 'assets/default_avatar.jpg'),
                          ),
                          title: Text(profile['name']),
                          subtitle: Text(profile['specializations'].join(', ')), // Join specializations with comma
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text('${profile['rating'].toStringAsFixed(1)}'),
                            ],
                          ),
                          onTap: () {
                            // Print all lawyer data to the console
                            print('Tapped Lawyer Data: $profile');

                            // Navigate to details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomescreenLawyerDetailsScreen(
                                  lawyerData: Map<String, dynamic>.from(profile),
                                  token: widget.token,
                                  userData: widget.userData,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
