//for newslink https://700f-2400-adca-116-bd00-bc82-d795-4c13-fcda.ngrok-free.app/recommend_news

import 'dart:convert';
//import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:project/Screens/news_details_page.dart';


const Color appBarColor = Color(0xFFDCBAFF);

class NewsPage extends StatelessWidget {
  final String userId;

  NewsPage({required this.userId});

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NEWS',
          style: TextStyle(color: Color(0xff30417c)),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: NewsList(userId: userId),
    );
  }
}

class NewsList extends StatefulWidget {
  final String userId;

  NewsList({required this.userId});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  Future<List<NewsItem>> _fetchNews() async {
  print("Fetching news for userId: ${widget.userId}");

  int maxRetries = 2;
  int retryCount = 0;
  List<NewsItem> newsItems = [];

  while (retryCount < maxRetries) {
    try {
      final response = await http.post(
        Uri.parse('https://36fd-2400-adca-116-bd00-2531-241-d8b3-542e.ngrok-free.app/recommend_news'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': widget.userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        newsItems = List<NewsItem>.from(
            data['articles'].map((item) => NewsItem.fromJson(item)));
        break;
      } else {
        print('Failed to load news with status code: ${response.statusCode}');
        throw Exception(
            'Failed to load news with status code: ${response.statusCode}');
      }
    } catch (e) {
      retryCount += 1;
      print('Error fetching news: $e. Retrying $retryCount/$maxRetries');
      await Future.delayed(Duration(seconds: 120)); // Consider changing the delay as needed
      if (retryCount >= maxRetries) {
        print('Max retries reached. Throwing exception.');
        throw Exception('Error fetching news: $e');
      }
    }
  }

  return newsItems;
}



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: _fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error fetching news: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final newsItem = snapshot.data![index];
              return NewsCard(
                newsItem: newsItem,
              );
            },
          );
        } else {
          return Center(child: Text('No news articles found.'));
        }
      },
    );
  }
}

class NewsItem {
  final String title;
  final String? urlToImage;
  final String url;
  final String description;
  final String author;
  final String source;
  final String content;

  NewsItem({
    required this.title,
    this.urlToImage,
    required this.url,
    required this.description,
    required this.author,
    required this.source,
    required this.content,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? "",
      urlToImage: json['urlToImage'],
      url: json['url'] ?? "",
      description: json['description'] ?? "",
      author: json['author'] ?? "",
      source: json['source']?['name'] ?? "",
      content: json['content'] ?? "",
    );
  }
}


class NewsCard extends StatelessWidget {
  final NewsItem newsItem;

  NewsCard({
    required this.newsItem,
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
                newsItem: newsItem,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (newsItem.urlToImage != null)
              Image.network(
                newsItem.urlToImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                newsItem.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                newsItem.description,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class NewsDetailsPage extends StatelessWidget {
  final NewsItem newsItem;

  NewsDetailsPage({
    required this.newsItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (newsItem.urlToImage != null)
              Image.network(
                newsItem.urlToImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                newsItem.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Author: ${newsItem.author}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Source: ${newsItem.source}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                newsItem.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => launchURL(newsItem.url),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Read more',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}

