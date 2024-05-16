import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/all_reviews.dart';
import 'package:project/Screens/lawyerprofile(browse).dart';
import 'writereview.dart';


class SearchPageLawyerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> lawyerData;
  final String token;
  final Map<String, dynamic> userData;

  SearchPageLawyerDetailsScreen({
    required this.lawyerData,
    required this.token,
    required this.userData,
  });

  @override
  _SearchPageLawyerDetailsScreenState createState() => _SearchPageLawyerDetailsScreenState();
}


class _SearchPageLawyerDetailsScreenState extends State<SearchPageLawyerDetailsScreen> {
  List<dynamic> reviews = [];
  bool loadingReviews = true;
  String errorMessage = '';
  bool isFavorited = false; // Add this variable to track favorite status

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call _fetchReviews() when dependencies change
    _fetchReviews();
  }

Future<void> _fetchReviews() async {
  setState(() {
    loadingReviews = true;
    errorMessage = '';
  });

  if (widget.lawyerData['lawyer_id'] == null) {
    setState(() {
      errorMessage = 'Lawyer ID is null. Please ensure it is correctly set.';
      loadingReviews = false;
    });
    return;
  }

  try {
    print("lawyerrr ${widget.lawyerData['lawyer_id']}");
        print("globaldata ${GlobalData().baseUrl}");

    var response = await http.get(
      Uri.parse('${GlobalData().baseUrl}/api/lawyers/ratings/${widget.lawyerData['lawyer_id']}'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        reviews = jsonDecode(response.body);
        loadingReviews = false;
      });
    } else {
      setState(() {
        errorMessage = 'Failed to fetch reviews. Please try again later.';
        loadingReviews = false;
      });
    }
  } catch (e) {
    setState(() {
      errorMessage = 'Error fetching reviews: $e';
      loadingReviews = false;
    });
  }
}

 Future<void> toggleFavorite() async {
  // Construct the request body
  var requestBody = jsonEncode({
    "client_id": widget.userData['id'],
    "lawyer_id": widget.lawyerData['lawyer_id'],
  });

  try {
    var response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/clients/favorites'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      // Favorite/unfavorite successful
      print('Favorite/unfavorite successful');
    } else {
      // Handle error
      print('Failed to favorite/unfavorite: ${response.body}');
    }
  } catch (e) {
    // Handle error
    print('Error favoriting/unfavoriting: $e');
  }
}


void _toggleFavorite() {
  setState(() {
    isFavorited = !isFavorited;
  });
  toggleFavorite(); // Call the toggleFavorite function here
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        title: Text('Lawyer Details'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.event_note, color: Color(0xFF912bFF)),
            onPressed: _showBookingDialog,
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFDCBAFF),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                          widget.lawyerData['profile_picture'] ?? 'default_image_url_here',
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited ? Colors.red : Colors.white,
                        ),
                        onPressed: _toggleFavorite, // Call _toggleFavorite on press
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '${widget.lawyerData['name']?? 'N/A'}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _parseSpecializations(widget.lawyerData['specializations']),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          double rating = double.tryParse('${widget.lawyerData['rating'] ?? "0"}') ?? 0.0;
                          IconData iconData;
                          Color iconColor;
                          if (index < rating.floor()) {
                            iconData = Icons.star;
                            iconColor = Colors.yellow;
                          } else if (index < rating && index + 1 > rating && (rating - rating.floor()) >= 0.5) {
                            iconData = Icons.star_half;
                            iconColor = Colors.yellow;
                          } else {
                            iconData = Icons.star_border;
                            iconColor = Colors.grey;
                          }
                          return Icon(iconData, color: iconColor);
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawyerProfilePageBrowse(
                            lawyerData: widget.lawyerData,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _navigateToWriteReviewScreen();
                            },
                          ),
                          Text(
                            'Reviews:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllReviewsScreen(
                                lawyerId: widget.lawyerData['lawyer_id'],  // Ensure this is the correct lawyer ID key
                                token: widget.token,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'All Reviews',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  loadingReviews
                      ? Center(child: CircularProgressIndicator())
                      : errorMessage.isNotEmpty
                          ? Center(child: Text(errorMessage))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                return _buildReviewWidget(index);
                              },
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildReviewWidget(int index) {
  if (index >= reviews.length) return Container(); // Safeguard for index bounds

  var review = reviews[index];
  var client = review['client'] ?? {}; // Default to an empty map if client is null
  String reviewerName = "${client['first_name'] ?? 'Anonymous'} ${client['last_name'] ?? ''}"; // Handle missing names
  double rating = review['ratings'] is int ? (review['ratings'] as int).toDouble() : review['ratings']; // Default rating
  String reviewText = review['comment_text'] ?? "No comment provided."; // Default text
  String profilePicture = client['profile_picture'] ?? 'assets/images/default_avatar.jpg'; // Default profile picture

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(profilePicture),
          ),
          SizedBox(width: 8.0),
          Text(reviewerName, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      Row(
        children: List.generate(
          5,
          (starIndex) {
            IconData iconData = starIndex < rating ? Icons.star : Icons.star_border;
            return Icon(iconData, color: Colors.yellow);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(reviewText),
      ),
      Divider(),
    ],
  );
}

  String _parseSpecializations(dynamic specializations) {
    if (specializations is List) {
      return specializations.join(", ");
    } else if (specializations is String) {
      return specializations;
    } else {
      return 'No specializations listed';
    }
  }

 void _navigateToWriteReviewScreen() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WriteReviewScreen(
        clientId: widget.userData['id'],
        lawyerId: widget.lawyerData['lawyer_id'],
        token: widget.token,
        onReviewSubmitted: _fetchReviews, // Pass the callback function
      ),
    ),
  );
}


 void _showBookingDialog() {
  final TextEditingController _reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Book Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                hintText: "Enter your reason for the appointment",
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Book'),
            onPressed: () {
              // Update the title right before booking
              String appointmentTitle = _reasonController.text.isNotEmpty ? _reasonController.text : "General Consultation";
              _bookAppointment(appointmentTitle);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> _bookAppointment(String reason) async {
  if (widget.userData['id'] == null || widget.lawyerData['lawyer_id'] == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Missing client or lawyer ID. Please make sure you are logged in and try again.')),
    );
    return;
  }

  try {
    var response = await http.post(
      Uri.parse('${GlobalData().baseUrl}/api/appointments'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode({
        'client_id': widget.userData['id'],
        'lawyer_id': widget.lawyerData['lawyer_id'],
        'appointment_title': reason,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment booked successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to book appointment. ${jsonDecode(response.body)['message']}')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error booking appointment. Please check your network connection.')));
  }
}

}