import 'package:flutter/material.dart';

class HomescreenLawyerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> lawyerData;

  HomescreenLawyerDetailsScreen({required this.lawyerData});

  @override
  _HomescreenLawyerDetailsScreenState createState() =>
      _HomescreenLawyerDetailsScreenState();
}

class _HomescreenLawyerDetailsScreenState
    extends State<HomescreenLawyerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        title: Text('Lawyer Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFFDCBAFF),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          AssetImage('assets/images/passport.png'),
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
                      // Implement your action here when the "View Details" button is pressed
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
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
                  // Reviews section heading
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // Use InkWell for tapping on "All Reviews"
                      InkWell(
                        onTap: () {
                          // Navigate to All Reviews page when "All Reviews" is tapped
                        },
                        child: Text(
                          'All Reviews',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // Display reviews using ListView.builder
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5, // Replace with the actual number of reviews
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
    // Replace the placeholder content with your actual review data
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
