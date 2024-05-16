import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/Screens/Global.dart';
import 'package:intl/intl.dart';


class AllReviewsScreen extends StatefulWidget {
  final String lawyerId;
  final String token;

  AllReviewsScreen({required this.lawyerId, required this.token});

  @override
  _AllReviewsScreenState createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {
  List<dynamic> reviews = [];
  bool isLoading = true;
  String errorMessage = '';

 @override
void initState() {
  super.initState();
  // Print lawyerId and Bearer token to the console for debugging
  print('Lawyer ID: ${widget.lawyerId}');
  print('Bearer Token: ${widget.token}');
  _fetchReviews();
}


Future<void> _fetchReviews() async {
  try {
    var url = Uri.parse('${GlobalData().baseUrl}/api/lawyers/ratings/${widget.lawyerId}');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print('Decoded response: $decodedResponse'); // Debug print the decoded response
      setState(() {
        reviews = decodedResponse;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load reviews with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception caught while fetching reviews: $e');
    setState(() {
      errorMessage = e.toString();
      isLoading = false;
    });
  }
}



 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('All Reviews'),
      backgroundColor: Color(0xFFdcbaff), // AppBar color
    ),
    backgroundColor: Color(0xFFdcbaff), // Make background color same as AppBar
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
          ? Text('Error: $errorMessage')
          : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return _buildReviewWidget(reviews[index]);
              },
            ),
  );
}

Widget _buildReviewWidget(dynamic review) {
  var client = review['client'] ?? {}; // Default to an empty map if client is null
  String fullName = "${client['first_name'] ?? 'Anonymous'} ${client['last_name'] ?? ''}";
  double rating = (review['ratings'] as num).toDouble(); // Ensure rating is always a double
  String reviewText = review['comment_text'] ?? "No comment provided."; // Default text
  String profilePicture = client['profile_picture'] ?? 'assets/images/default_avatar.jpg'; // Default profile picture

  // Parsing and formatting the date
  String rawDate = review['created_at'] ?? "";
  String formattedDate = formatDate(rawDate);

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(profilePicture),
              ),
              SizedBox(width: 8.0),
              Expanded( // Make text not overflow
                child: Text(
                  fullName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // Prevents text overflow
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20.0,
              );
            }),
          ),
          SizedBox(height: 8.0),
          Text(
            reviewText,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 4.0),
          Text(
            'Submitted on: $formattedDate',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

String formatDate(String dateStr) {
  if (dateStr.isEmpty) return "Date not available";
  try {
    DateTime parsedDate = DateTime.parse(dateStr);
    return DateFormat('MMMM dd, yyyy – hh:mm a').format(parsedDate);
  } catch (e) {
    print('Error parsing date: $e');
    return "Invalid date";
  }
}
}