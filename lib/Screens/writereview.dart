import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
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
              onPressed: () {
                // Save the review and navigate back
                Navigator.pop(context, {
                  'rating': rating,
                  'review': reviewController.text,
                });
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
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
