import 'package:flutter/material.dart';
import 'dart:math';

class AllReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('All Reviews')),
        backgroundColor: Color(0xFFdcbaff),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return _buildReviewWidget(index);
        },
      ),
    );
  }

  Widget _buildReviewWidget(int index) {
    // Generate random data
    final String reviewerName = '${_generateRandomName()}';
    final String reviewText = '${_generateRandomReview()}';
    final String dateOfReview = '\nSubmitted on: ${_generateRandomDate()}';

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
