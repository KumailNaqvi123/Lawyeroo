import 'package:flutter/material.dart';
import 'package:project/Screens/news_details_page.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
        centerTitle: true,
        backgroundColor: Color(0xFFDCBAFF),
      ),
      body: NewsList(),
    );
  }
}

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NewsItem> news = [
      NewsItem(
        title: 'Breaking News: Flutter 3.0 Released!',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article1',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
      NewsItem(
        title: 'Tech Giants Announce Collaboration on AI Research',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article2',
        body: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      ),
      NewsItem(
        title: 'SpaceX Launches New Mission to Mars',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article3',
        body: 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      ),
    ];

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: NewsCard(
            title: news[index].title,
            imageAsset: news[index].imageAsset,
            fullArticleUrl: news[index].fullArticleUrl,
            body: news[index].body,
          ),
        );
      },
    );
  }
}

class NewsItem {
  final String title;
  final String imageAsset;
  final String fullArticleUrl;
  final String body;

  NewsItem({
    required this.title,
    required this.imageAsset,
    required this.fullArticleUrl,
    required this.body,
  });
}

class NewsCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final String fullArticleUrl;
  final String body;

  NewsCard({
    required this.title,
    required this.imageAsset,
    required this.fullArticleUrl,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          Container(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  body,
                  style: TextStyle(fontSize: 16),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
