import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';

class WriteReviewScreen extends StatefulWidget {
  final String clientId;
  final String lawyerId;
  final String token;
  final Function onReviewSubmitted; // Add this callback function

  WriteReviewScreen({
    required this.clientId,
    required this.lawyerId,
    required this.token,
    required this.onReviewSubmitted, // Pass the callback function
  });

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  double rating = 0.0;
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Rating stars
            RatingBar(
              onRatingChanged: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            SizedBox(height: 16.0),
            // Review text field
            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Submit button
            ElevatedButton(
              onPressed: _submitReview,
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    String reviewText = reviewController.text;

    if (reviewText.isEmpty || rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and a review.')),
      );
      return;
    }

    var url = Uri.parse('${GlobalData().baseUrl}/api/lawyers/ratings/');

    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({
          'client_id': widget.clientId,
          'lawyer_id': widget.lawyerId,
          'ratings': rating,
          'comment_text': reviewText,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review submitted successfully!')),
        );
        widget.onReviewSubmitted(); // Call the callback function
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting review.')),
      );
    }
  }
}

class RatingBar extends StatefulWidget {
  final Function(double) onRatingChanged;

  RatingBar({required this.onRatingChanged});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.star, color: rating >= 1 ? Colors.amber : Colors.grey),
          onPressed: () => updateRating(1),
        ),
        IconButton(
          icon: Icon(Icons.star, color: rating >= 2 ? Colors.amber : Colors.grey),
          onPressed: () => updateRating(2),
        ),
        IconButton(
          icon: Icon(Icons.star, color: rating >= 3 ? Colors.amber : Colors.grey),
          onPressed: () => updateRating(3),
        ),
        IconButton(
          icon: Icon(Icons.star, color: rating >= 4 ? Colors.amber : Colors.grey),
          onPressed: () => updateRating(4),
        ),
        IconButton(
          icon: Icon(Icons.star, color: rating >= 5 ? Colors.amber : Colors.grey),
          onPressed: () => updateRating(5),
        ),
      ],
    );
  }

  void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
    widget.onRatingChanged(rating);
  }
}
