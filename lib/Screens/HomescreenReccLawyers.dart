import 'package:flutter/material.dart';
import 'dart:math';
import 'package:project/Screens/LawyerDetailsScreen.dart';

class HomescreenReccLawyers extends StatefulWidget {
  @override
  _HomescreenLawyerDetailsScreenState createState() =>
      _HomescreenLawyerDetailsScreenState();
}

class _HomescreenLawyerDetailsScreenState
    extends State<HomescreenReccLawyers> {
  // Dummy lawyer profiles
  final List<dynamic> lawyerProfiles = [
    {
      'name': 'Lawyer 1',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport1.png', // Add the path to your images
    },
    {
      'name': 'Lawyer 2',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport2.png',
    },
    {
      'name': 'Lawyer 3',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport3.png', // Add the path to your images
    },
    {
      'name': 'Lawyer 4',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport4.png',
    },
    {
      'name': 'Lawyer 5',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport5.png', // Add the path to your images
    },
    {
      'name': 'Lawyer 6',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport6.png',
    },
    {
      'name': 'Lawyer 7',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport7.png', // Add the path to your images
    },
    {
      'name': 'Lawyer 8',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport8.png',
    },
  ];

  List<dynamic> filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    filteredProfiles = List.from(lawyerProfiles);
  }

  void filterProfiles(String searchText) {
    setState(() {
      filteredProfiles = lawyerProfiles
          .where((profile) =>
              profile['name'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Recommended Lawyers',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFFDCBAFF), // Change the app bar color
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1), // Change the background color
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: filterProfiles,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      if (filteredProfiles[index] is Map<String, dynamic>) {
                        double rating =
                            filteredProfiles[index]['rating'] as double;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                            vertical: constraints.maxWidth * 0.03,
                          ),
                          child: IntrinsicHeight(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LawyerDetailsScreen(
                                      lawyerData: filteredProfiles[index],
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Set button background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding:
                                    EdgeInsets.all(constraints.maxWidth * 0.03),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            filteredProfiles[index]['image']),
                                        radius: constraints.maxWidth * 0.1,
                                      ),
                                      SizedBox(width: constraints.maxWidth * 0.03),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredProfiles[index]['name'] as String,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: constraints.maxWidth * 0.06,
                                            ),
                                          ),
                                          Text(
                                            filteredProfiles[index]['specification']
                                                as String,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: constraints.maxWidth * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: constraints.maxWidth * 0.06,
                                        ),
                                        Text(
                                          rating.toStringAsFixed(1),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth * 0.04,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
