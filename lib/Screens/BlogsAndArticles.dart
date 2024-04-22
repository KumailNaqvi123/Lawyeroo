import 'package:flutter/material.dart';
import 'package:project/Screens/ArticleDetailsPage.dart';
import 'package:project/Screens/lawyerhomepage.dart'; // Import the LawyerHomepage

class LawyerBlogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to LawyerHomepage when back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LawyerHomepage()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Legal Blogs & Articles'),
          backgroundColor: Color(0xFFDCBAFF),
        ),
        backgroundColor: Color(0xFFB884D1),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildArticleCard(
              context: context,
              title: 'Understanding Intellectual Property Rights',
              author: 'John Doe',
              date: 'January 15, 2024',
              image: 'assets/images/house.jpg',
              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...',
            ),
            SizedBox(height: 16),
            _buildArticleCard(
              context: context,
              title: 'Key Elements of a Contract',
              author: 'Jane Smith',
              date: 'February 5, 2024',
              image: 'assets/images/contract.jpg',
              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required BuildContext context,
    required String title,
    required String author,
    required String date,
    required String image,
    required String content,
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _navigateToArticleDetails(context, title, author, date, image, content);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'By $author',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToArticleDetails(
    BuildContext context,
    String title,
    String author,
    String date,
    String image,
    String content,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailsPage(title: title, author: author, date: date, image: image, content: content),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LawyerBlogsPage(),
  ));
}
