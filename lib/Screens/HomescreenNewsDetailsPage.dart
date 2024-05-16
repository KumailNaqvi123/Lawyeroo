import 'package:flutter/material.dart';
import 'package:project/Screens/newsdefinition.dart';
import 'package:url_launcher/url_launcher.dart';

class HomescreenNewsDetailsPage extends StatelessWidget {
  final ClientNewsItem newsItem;

  const HomescreenNewsDetailsPage({Key? key, required this.newsItem}) : super(key: key);

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('News Details'),
      backgroundColor: Color(0xFFDCBAFF),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(newsItem.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            if (newsItem.urlToImage != null)
              Image.network(newsItem.urlToImage!),
            SizedBox(height: 10),
            Text('Published on: ${DateTime.parse(newsItem.publishedAt).toLocal()}'),
            SizedBox(height: 10),
            Text('Author: ${newsItem.author}'),
            SizedBox(height: 10),
            Text('Source: ${newsItem.source['name']}'),
            SizedBox(height: 10),
            Text(newsItem.content ?? 'No content available'),  // Display content with null check
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text('Read full article', style: TextStyle(color: Colors.blue)),
                onTap: () async {
                  final Uri _url = Uri.parse(newsItem.url);
                  if (await canLaunchUrl(_url)) {
                    await launchUrl(_url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch the article'))
                    );
                  }
                },
              ),
            ),
          ],
        ),
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