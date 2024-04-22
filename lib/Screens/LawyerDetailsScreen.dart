import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/Screens/Lawyerprofile.dart';
import 'package:project/Screens/all_reviews.dart';
import 'package:project/Screens/lawyerprofile(browse).dart';
import 'writereview.dart'; // Import the writereview.dart file

class LawyerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> lawyerData;

  LawyerDetailsScreen({required this.lawyerData});

  @override
  _LawyerDetailsScreenState createState() => _LawyerDetailsScreenState();
}

class _LawyerDetailsScreenState extends State<LawyerDetailsScreen> {
  bool showAllReviews = false;

  void _navigateToWriteReviewScreen() async {
    final Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WriteReviewScreen()),
    );

    // Handle the submitted review
    if (result != null) {
      double submittedRating = result['rating'];
      String submittedReview = result['review'];

      // You can now update your data model or perform any necessary actions with the review
      // For example, you can add it to a list of reviews and rebuild the widget
      setState(() {
        // Assuming you have a list of reviews
        // reviews.add({
        //   'rating': submittedRating,
        //   'review': submittedReview,
        // });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFFdcbaff),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16.0), // Added padding above the profile picture
                Center(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/passport.png'),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${widget.lawyerData['name']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${widget.lawyerData['specification']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < widget.lawyerData['rating']
                              ? Colors.yellow
                              : Colors.grey,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // "View Details" button
                TextButton(
                  onPressed: () {
                    // Navigate to LawyerProfilePage when "View Details" is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LawyerProfilePageBrowse(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Color(0xFFb884d1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reviews section heading
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add, color: Color(0xffb884d1)),
                            onPressed: () {
                              _navigateToWriteReviewScreen();
                            },
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Reviews:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Use InkWell for tapping on "All Reviews"
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllReviewsScreen()),
                          );
                        },
                        child: Text(
                          'All Reviews',
                          style: TextStyle(fontSize: 16, color: Color(0xffb884d1)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // Generate reviews based on showAllReviews flag
                  showAllReviews
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return _buildReviewWidget(index);
                            },
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return _buildReviewWidget(index);
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewWidget(int index) {
    // Generate random data
    final String reviewerName = _generateRandomName();
    final String reviewText = _generateRandomReview();
    final String dateOfReview = '\nSubmitted on: ${_generateRandomDate()}';

    return Column(
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
        Text(reviewText),
        Text(dateOfReview),
        Divider(),
      ],
    );
  }

  String _generateRandomName() {
    final List<String> names = ['Alice', 'Bob', 'Charlie', 'David', 'Eva'];
    return names[Random().nextInt(names.length)];
  }

  String _generateRandomReview() {
    final List<String> reviews = [
      'Excellent service, highly recommended!',
      'Amazing service, still has room for improvement.',
      'Very professional and knowledgeable.',
      'Great communication skills.'
    ];
    return reviews[Random().nextInt(reviews.length)];
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


/*
import 'package:flutter/material.dart';
import 'package:project/Screens/all_reviews.dart';

class LawyerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> lawyerData;

  LawyerDetailsScreen({required this.lawyerData});

  @override
  _LawyerDetailsScreenState createState() => _LawyerDetailsScreenState();
}

class _LawyerDetailsScreenState extends State<LawyerDetailsScreen> {
  bool showAllReviews = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/passport.png'),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${widget.lawyerData['name']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${widget.lawyerData['specification']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < widget.lawyerData['rating']
                              ? Colors.yellow
                              : Colors.grey,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reviews section
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Use InkWell for tapping on "All Reviews"
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllReviewsScreen()),
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
                    // Generate reviews based on showAllReviews flag
                    showAllReviews
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return _buildReviewWidget(index);
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return _buildReviewWidget(index);
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/passport.png'),
            ),
            SizedBox(width: 8.0),
            Text('Reviewer Name $index'),
          ],
        ),
        Row(
          children: List.generate(5, (starIndex) {
            return Icon(
              Icons.star,
              color: Colors.yellow,
            );
          }),
        ),
        Text('Random review text $index'),
        Text('Date and Time of Review $index'),
        Divider(),
      ],
    );
  }
}
*/