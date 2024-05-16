import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:project/Screens/Global.dart';

class MyStatisticsPage extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData;

  MyStatisticsPage({required this.token, required this.userData});

  @override
  _MyStatisticsPageState createState() => _MyStatisticsPageState();
}

class _MyStatisticsPageState extends State<MyStatisticsPage> {
  double meanRating = 0.0;
  List<String> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  Future<void> fetchRatings() async {
  final url = Uri.parse('${GlobalData().baseUrl}/api/lawyers/ratings/${widget.userData['id']}');
  try {
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${widget.token}'}
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      double totalRating = 0.0;
      List<String> reviewTexts = [];
      for (var reviewData in data) {
        totalRating += reviewData['ratings']; // Access 'ratings' as a double
        reviewTexts.add(reviewData['comment_text']);
      }
      double mean = totalRating / data.length;
      setState(() {
        meanRating = mean;
        reviews = reviewTexts;
      });
    } else {
      print('Failed to fetch ratings: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching ratings: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Statistics'),
        backgroundColor: Color(0xFFDCBAFF), // Set the app bar color
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white, // Set the background color
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _buildMeanRatingCircle(),
              SizedBox(height: 20),
              Text(
                'Recent Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildRecentReviews(),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildMeanRatingCircle() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Average Rating',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Container(
        width: 140, // Increased the width
        height: 140, // Increased the height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFFb884d1), // Set the border color
            width: 8, // Set the border thickness
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120, // Adjusted the width
              height: 120, // Adjusted the height
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: 32, // Adjusted the position
              child: Text(
                meanRating.toStringAsFixed(1), // Use the fetched meanRating
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 32, // Adjusted the position
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) {
                    double starValue = index + 1.0;

                    // Use Icons.star or Icons.star_half based on the starValue
                    IconData starIcon = starValue <= meanRating
                        ? Icons.star
                        : starValue - 0.5 <= meanRating
                            ? Icons.star_half
                            : Icons.star_border;

                    return Icon(
                      starIcon,
                      color: Colors.yellow, // Set the color of the stars
                      size: 20, // Set the size of the stars
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildRecentReviews() {
    // Generate some random reviews for demonstration
    List<String> reviews = [
      'Great service! Highly recommended.',
      'Could improve communication.',
      'Outstanding performance!',
      'Average service. Room for improvement.',
    ];

    return Column(
      children: reviews.map((review) {
        return _buildReviewWidget(review);
      }).toList(),
    );
  }

  Widget _buildReviewWidget(String reviewText) {
    // Generate random data
    final String reviewerName = '${_generateRandomName()}';
    final String dateOfReview = '${_generateRandomDate()}';

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/passport.png'),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewerName),
                  Row(
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0, // Adjust the size as needed
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(reviewText),
          Text(dateOfReview),
          Divider(),
        ],
      ),
    );
  }

  String _generateRandomName() {
    final List<String> names = ['Ahmed', 'Ali', 'Hassan', 'Hamza', 'Usama'];
    return names[Random().nextInt(names.length)];
  }

  String _generateRandomDate() {
    // Generate random date within the last month
    final DateTime now = DateTime.now();
    final int randomDay = Random().nextInt(30) + 1; // Random day between 1 and 30
    final DateTime randomDate = now.subtract(Duration(days: randomDay));

    // Format the date
    final String formattedDate =
        '${_addLeadingZero(randomDate.day)}/${_addLeadingZero(randomDate.month)}/${randomDate.year}';

    return formattedDate;
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}
