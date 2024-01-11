import 'package:flutter/material.dart';
import 'package:project/Screens/HomescreenLawyerDetailsPage.dart';

class FavoriteLawyersPage extends StatefulWidget {
  static List<Map<String, dynamic>> favoriteLawyerProfiles = [
    {
      'name': 'Favorite Lawyer 1',
      'specification': 'Criminal Defense',
      'rating': 4.5,
      'image': 'assets/images/passport1.png',
    },
    {
      'name': 'Favorite Lawyer 2',
      'specification': 'Family Law',
      'rating': 4.2,
      'image': 'assets/images/passport2.png',
    },
    // Add more favorite lawyers as needed
  ];

  @override
  _FavoriteLawyersPageState createState() => _FavoriteLawyersPageState();
}

class _FavoriteLawyersPageState extends State<FavoriteLawyersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFdcbaff),
        title: Text('Favorite Lawyers'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: FavoriteLawyersPage.favoriteLawyerProfiles.length,
                    itemBuilder: (context, index) {
                      double rating = FavoriteLawyersPage.favoriteLawyerProfiles[index]['rating'] as double;

                      String fullName = FavoriteLawyersPage.favoriteLawyerProfiles[index]['name'] as String;
                      List<String> nameParts = fullName.split(' ');
                      String truncatedName = '${nameParts[0]} ${nameParts.length > 1 ? nameParts[1].substring(0, 3) + '...' : ''}';

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                          vertical: constraints.maxWidth * 0.03,
                        ),
                        child: IntrinsicHeight(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the HomescreenLawyerDetailsScreen when the card is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomescreenLawyerDetailsScreen(
                                    lawyerData: FavoriteLawyersPage.favoriteLawyerProfiles[index],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: constraints.maxWidth * 0.06,
                                    ),
                                    SizedBox(width: constraints.maxWidth * 0.02),
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        FavoriteLawyersPage.favoriteLawyerProfiles[index]['image'] as String,
                                      ),
                                      radius: constraints.maxWidth * 0.1,
                                    ),
                                    SizedBox(width: constraints.maxWidth * 0.03),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          truncatedName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: constraints.maxWidth * 0.06,
                                          ),
                                        ),
                                        Text(
                                          FavoriteLawyersPage.favoriteLawyerProfiles[index]['specification'] as String,
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
                                  padding: EdgeInsets.all(constraints.maxWidth * 0.01),
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
                                        size: constraints.maxWidth * 0.04,
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth * 0.05,
                                        ),
                                        child: Text(
                                          rating.toStringAsFixed(1),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: constraints.maxWidth * 0.03,
                                          ),
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
