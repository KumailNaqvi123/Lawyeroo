import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'dart:convert';

class FavoriteLawyersPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  FavoriteLawyersPage({required this.token, required this.userData});

  @override
  _FavoriteLawyersPageState createState() => _FavoriteLawyersPageState();
}

class _FavoriteLawyersPageState extends State<FavoriteLawyersPage> {
  List<Map<String, dynamic>> favoriteLawyerProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteLawyers();
    print('You are on the Favorite Lawyers page');
    print('User data received: ${widget.userData}');
    print('Token received: ${widget.token}');
  }

  Future<void> fetchFavoriteLawyers() async {
    final url = Uri.parse('${GlobalData().baseUrl}/api/clients/${widget.userData['id']}/favorites');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          favoriteLawyerProfiles = List<Map<String, dynamic>>.from(data.map((lawyer) {
            var specializations = lawyer['specializations'];
            if (specializations is String) {
              specializations = jsonDecode(specializations);
            }
            return {
              'lawyer_id': lawyer['lawyer_id'],
              'name': '${lawyer['first_name']} ${lawyer['last_name']}',
              'specialization': specializations.join(', ') ?? 'No specialization',
              'rating': double.tryParse(lawyer['rating'].toString()) ?? 0.0,
              'image': lawyer['profile_picture'] ?? 'default_image_url',
              'isFavorite': true  // Assume all fetched lawyers are favorites initially
            };
          }));
        });
      } else {
        print('Failed to load favorite lawyers: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorite lawyers: $e');
    }
  }

  void toggleFavorite(int index) {
    var lawyer = favoriteLawyerProfiles[index];
    var url = Uri.parse('${GlobalData().baseUrl}/api/clients/${widget.userData['id']}/favorites/${lawyer['lawyer_id']}');

    // Determine if we should POST (favorite) or DELETE (unfavorite)
    var request = lawyer['isFavorite']
        ? http.delete(url, headers: {'Authorization': 'Bearer ${widget.token}'}) // Use DELETE to unfavorite
        : http.post(url, headers: {'Authorization': 'Bearer ${widget.token}', 'Content-Type': 'application/json'}); // Use POST to favorite

    request.then((response) {
      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          if (lawyer['isFavorite']) {
            // If the lawyer was unfavorited successfully, remove them from the list
            favoriteLawyerProfiles.removeAt(index);
          } else {
            // If the lawyer was favorited successfully, just update the state
            lawyer['isFavorite'] = !lawyer['isFavorite'];
          }
        });
      } else {
        // If the server toggle failed, revert the change locally
        setState(() {
          lawyer['isFavorite'] = !lawyer['isFavorite'];
        });
        print('Failed to toggle favorite on server. Status was: ${response.statusCode}');
      }
    }).catchError((error) {
      // On error, also revert the change locally
      setState(() {
        lawyer['isFavorite'] = !lawyer['isFavorite'];
      });
      print('Error toggling favorite: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFdcbaff),
        title: Text('Favorite Lawyers'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteLawyerProfiles.length,
                    itemBuilder: (context, index) {
                      var lawyer = favoriteLawyerProfiles[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                          vertical: constraints.maxWidth * 0.03,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  lawyer['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () => toggleFavorite(index),
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(lawyer['image']),
                                radius: constraints.maxWidth * 0.1,
                              ),
                              SizedBox(width: constraints.maxWidth * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lawyer['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth * 0.05,
                                      ),
                                    ),
                                    Text(
                                      lawyer['specialization'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: constraints.maxWidth * 0.04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                lawyer['rating'].toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: constraints.maxWidth * 0.04,
                                  color: Colors.orange,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: constraints.maxWidth * 0.05,
                              ),
                            ],
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
