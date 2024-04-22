import 'package:flutter/material.dart';
import 'package:project/Screens/news_details_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<String> newsTypes = ['All', 'Tech', 'Space', 'Breaking'];

  String selectedFilter = 'All'; // Initially set to show all news

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
        centerTitle: true,
        backgroundColor: Color(0xFFDCBAFF),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            itemBuilder: (BuildContext context) {
              return newsTypes.map((String type) {
                return PopupMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList();
            },
            onSelected: (String value) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),
        ],
      ),
      body: NewsList(selectedFilter: selectedFilter),
    );
  }
}

class NewsList extends StatelessWidget {
  final String selectedFilter;

  NewsList({required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    List<NewsItem> news = [
      NewsItem(
        title: 'Breaking News: Flutter 3.0 Released!',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article1',
        type: 'Breaking',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
      NewsItem(
        title: 'Tech Giants Announce Collaboration on AI Research',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article2',
        type: 'Tech',
        body: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      ),
      NewsItem(
        title: 'SpaceX Launches New Mission to Mars',
        imageAsset: 'assets/images/News_Thumbnail.png',
        fullArticleUrl: 'https://example.com/full_article3',
        type: 'Space',
        body: 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      ),
    ];

    // Apply filtering
    List<NewsItem> filteredNews = selectedFilter == 'All'
        ? news
        : news.where((newsItem) => newsItem.type == selectedFilter).toList();

    return ListView.builder(
      itemCount: filteredNews.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: NewsCard(
            title: filteredNews[index].title,
            imageAsset: filteredNews[index].imageAsset,
            fullArticleUrl: filteredNews[index].fullArticleUrl,
            body: filteredNews[index].body,
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
  final String type; // Added type field for filtering
  final String body;

  NewsItem({
    required this.title,
    required this.imageAsset,
    required this.fullArticleUrl,
    required this.type,
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
