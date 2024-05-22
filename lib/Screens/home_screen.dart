import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Screens/Global.dart';
import 'package:project/Screens/HomescreenLawyerDetailsPage.dart';
// import 'package:project/Screens/HomescreenLawyerDetailsPage2.dart';
import 'package:project/Screens/HomescreenNewsDetailsPage.dart';
import 'package:project/Screens/HomescreenReccLawyers.dart';
import 'package:project/Screens/News.dart';
import 'package:project/Screens/SearchPage.dart';
import 'package:project/Screens/Settings.dart';
import 'package:project/Screens/contact_screen.dart';
import 'package:project/Screens/notifications.dart';
import 'package:project/Screens/qna_board.dart';
import 'package:project/Screens/newsdefinition.dart';


class MyApp extends StatelessWidget {
  final String token;
  final Map<String, dynamic> userData; // Add this line

  MyApp({required this.token, required this.userData}); // Modify constructor to accept userData

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(token: token, userData: userData), // Pass userData to HomeScreen
    );
  }
}


class HomeScreen extends StatefulWidget {
  final String token;
  final Map<String, dynamic> userData; // Add userData as a parameter

  HomeScreen({required this.token, required this.userData}); // Update constructor to receive userData

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  List<dynamic> lawyersData = [];
  List<ClientNewsItem> clientNewsItems = [];
  List<dynamic> lawyersData2 = [];

  @override
  void initState() {
  super.initState();
  
_fetchClientNews().then((items) {
  setState(() {
    clientNewsItems = items.take(5).toList(); // Take only the first five items
     print('News items set in state: $clientNewsItems');  
  });
}).catchError((error) {
  print('Error fetching news: $error');
});

      super.initState();
    _fetchLawyersData();
    _fetchNearbyLawyersData();
    print("Current Page: Home Screen");
    print("Token: ${widget.token}"); // Print the token
    print("User Data: ${widget.userData}"); // Print all user data
    print("Passed Lawyer Data: $lawyersData");
    print ("PASSED LAWYERS DATA: $lawyersData2");
}

Future<List<ClientNewsItem>> _fetchClientNews() async {
  print(" clients id ${widget.userData['id']}");
  final response = await http.post(
    Uri.parse('https://36fd-2400-adca-116-bd00-2531-241-d8b3-542e.ngrok-free.app/recommend_news'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'user_id': widget.userData['id']}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<ClientNewsItem> newsItems = (data['articles'] as List).map((item) => ClientNewsItem.fromJson(item)).toList();
    return newsItems;
  } else {
    throw Exception('Failed to load news: ${response.statusCode}');
  }
}



Future<void> _fetchLawyersData() async {
  try {
    final response = await http.get(
      Uri.parse('http://3.144.71.210:8000/recommendations?client_id=${GlobalData().userData['id']}'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> recommendedLawyers = json['recommended_lawyers'] ?? [];
      List<Map<String, dynamic>> lawyers = recommendedLawyers.map<Map<String, dynamic>>((data) {
        return {
          'account_type': data['account_type'] ?? 'Lawyer',
          'address': data['address'] ?? 'No address provided',
          'email': data['email'] ?? 'No email provided',
          'fees': data['fees'] is double ? data['fees'] : 0.0,
          'first_name': data['first_name'] ?? 'Unknown',
          'last_name': data['last_name'] ?? 'Unknown',
          'lawyer_id': data['lawyer_id'] ?? 'No ID',
          'ph_number': data['ph_number'] ?? 'No phone number',
          'profile_picture': data['profile_picture'] ?? 'default_image_url',
          'rating': data['rating'] is double ? data['rating'] : 0.0,
          'rating_count': data['rating_count'] is int ? data['rating_count'] : 0,
          'specializations': data['specializations'] ?? ['No specialization'],
          'universities': data['universities'] ?? 'Unknown',
          'verified': data['verified'] ?? false,
          'years_of_experience': data['years_of_experience'],
          'conversations': data['conversations'] ?? {'-Nvs0D2WqXpuqNOCnLEC_-NwBB-yOIGQlqLonV6Cx': true},
        };
      }).toList();

      setState(() {
        lawyersData = lawyers;
      });
      print('RECOMMENDED LAWYER DATA: $lawyersData');
    } else {
      print('Failed to load recommended lawyer data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching recommended lawyer data: $e');
  }
}

  
Future<void> _fetchNearbyLawyersData() async {
  // Prepare the URI and headers
  var uri = Uri.parse('${GlobalData().baseUrl}/api/lawyers/nearby-lawyers');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${widget.token}',  // Ensure the token is taken from widget.token or a similar source
  };

  // Prepare the body of the request
  var body = jsonEncode({
    "address": widget.userData['address'] ?? "Default Address"
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> responseData2 = jsonDecode(response.body);
      print('Fetched Data2: $responseData2');
      setState(() {
        lawyersData2 = responseData2; // Assuming this variable is used to store the lawyers data
      });
      print('Nearby lawyers data fetched successfully.');
    } else {
      print('Failed to load nearby lawyers data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching nearby lawyers data: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDCBAFF),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/L.png',
              width: 30, // Adjust the size of the logo
              height: 30, // Adjust the size of the logo
            ),
            SizedBox(width: 8), // Adjust the spacing between logo and title
            Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff30417c),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFB884D1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(token: widget.token, userData: widget.userData),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Text('Search...'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeading('Recent News'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsPage(userId: widget.userData['id'].toString())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 16, bottom: 8),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: clientNewsItems.length, // This is now up to five
                  onPageChanged: (int index) {
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _buildRecentNewsItem(context, index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeading('Recommended Lawyers'),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomescreenReccLawyers(
                            token: widget.token,
                            userData: widget.userData,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 16, bottom: 8),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildProfileItem(context, index);
                  },
                ),
              ),
              _buildSectionHeading('Lawyers near you'),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildVerticalListItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildNavBar(),   
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

Widget _buildRecentNewsItem(BuildContext context, int index) {
  if (index >= clientNewsItems.length) return Container(); // Ensure index is within range

  ClientNewsItem newsItem = clientNewsItems[index];
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomescreenNewsDetailsPage(newsItem: newsItem),
        ),
      );
    },
    child: Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsItem.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  newsItem.urlToImage!,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                newsItem.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                newsItem.description ?? 'No description available', // Use description with a null check
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
void printJsonWithTypes(Map<String, dynamic> jsonObject) {
  jsonObject.forEach((key, value) {
    print('$key: $value (${value.runtimeType})');
  });
}

Widget _buildProfileItem(BuildContext context, int index) {
  if (lawyersData.isEmpty || index >= lawyersData.length) return Container();

  var lawyer = lawyersData[index];
  return GestureDetector(
    onTap: () {
      print("Recommended Lawyer data $lawyer");
      printJsonWithTypes(lawyer);
      // Passing the specific lawyer data from recommended lawyers when this profile is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomescreenLawyerDetailsScreen(
          lawyerData: lawyer, 
          token: widget.token, 
          userData: widget.userData
        )),
      );
    },
    child: Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture and other details
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(lawyer['profile_picture'] ?? 'assets/images/default_lawyer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "${lawyer['first_name']} ${lawyer['last_name']}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Fee: \$${lawyer['fees']}",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
Widget _buildVerticalListItem(int index) {
  if (lawyersData2.isEmpty || index >= lawyersData2.length) return Container(); // Ensure we are checking `lawyersData2`

  var lawyer = lawyersData2[index] as Map<String, dynamic>; // Ensure `lawyer` is of type Map<String, dynamic>
  // Create a new Map that includes the lawyer_id
   lawyer = {
    ...lawyer,
    'lawyer_id': lawyer['id'], // Add the lawyer_id
  };
  print("Nearby lawyeer details $lawyer");
        printJsonWithTypes(lawyer);

  return Card(
    margin: EdgeInsets.all(8),
    color: Colors.white.withOpacity(0.9),  // Translucent background
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(lawyer['profile_picture'] ?? 'assets/images/default_lawyer.jpg'),
      ),
      title: Text("${lawyer['first_name']} ${lawyer['last_name']}"),
      subtitle: Text("Specializations: ${lawyer['specializations']}"),
      trailing: Text("\$${lawyer['fees']}"),
    onTap: () {
      print("Recommended Lawyer data $lawyer");
      // Passing the specific lawyer data from recommended lawyers when this profile is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomescreenLawyerDetailsScreen(
          lawyerData: lawyer, 
          token: widget.token, 
          userData: widget.userData
        )),
      );
    },    ),
  );
}




  Widget _buildNavBar() {
    return Container(
      color: Color(0xFFDCBAFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFF912bFF)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(token: widget.token, userData: widget.userData),
              ),
              (route) => false,
            );

            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
builder: (context) => ContactsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.article),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsPage(userId: widget.userData['id'].toString(),)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QnABoard(token: widget.token, userData: widget.userData)),
              );
            },
          ),
          IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage(token: widget.token, userData:widget.userData, lawyerData: lawyersData)),
            );
          },
        ),
        ],
      ),
    );
  }
}