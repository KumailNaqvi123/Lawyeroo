import 'package:flutter/material.dart';
import 'package:project/Screens/news_details_page.dart';

class LNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
        centerTitle: true, // Center align the title
        backgroundColor: Color(0xFFDCBAFF), // Set the background color of AppBar
      ),
      body: LNewsList(),
    );
  }
}

class LNewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual news data or fetch from an API
    List<LNewsItem> news = [
      LNewsItem(
        title: 'News 1: This is the first news article.',
        imageAsset: 'assets/images/News_Thumbnail.png', // Replace with actual asset path
        fullArticleUrl: 'https://example.com/full_article1', // Replace with actual URL
      ),
      LNewsItem(
        title: 'News 2: Another interesting news piece.',
        imageAsset: 'assets/images/News_Thumbnail.png', // Replace with actual asset path
        fullArticleUrl: 'https://example.com/full_article2', // Replace with actual URL
      ),
      LNewsItem(
        title: 'News 3: Stay tuned for more updates.',
        imageAsset: 'assets/images/News_Thumbnail.png', // Replace with actual asset path
        fullArticleUrl: 'https://example.com/full_article3', // Replace with actual URL
      ),
    ];

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return LNewsCard(
          title: news[index].title,
          imageAsset: news[index].imageAsset,
          fullArticleUrl: news[index].fullArticleUrl,
        );
      },
    );
  }
}

class LNewsItem {
  final String title;
  final String imageAsset;
  final String fullArticleUrl;

  LNewsItem({
    required this.title,
    required this.imageAsset,
    required this.fullArticleUrl,
  });
}

class LNewsCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final String fullArticleUrl;

  LNewsCard({
    required this.title,
    required this.imageAsset,
    required this.fullArticleUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsPage(
                title: title,
                imageAsset: imageAsset,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imageAsset,
              height: 200, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
