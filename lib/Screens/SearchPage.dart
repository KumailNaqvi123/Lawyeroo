import 'package:flutter/material.dart';
import 'dart:math';
import 'package:project/Screens/LawyerDetailsScreen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> lawyerTypes = ['All', 'Criminal Defense', 'Family Law'];
  String selectedLawyerType = 'All';

  final List<dynamic> lawyerProfiles = [
    {
      'name': 'Lawyer 1',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport1.png',
    },
    {
      'name': 'Lawyer 2',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport2.png',
    },
    {
      'name': 'Lawyer 3',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport3.png',
    },
    {
      'name': 'Lawyer 4',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport4.png',
    },
    {
      'name': 'Lawyer 5',
      'specification': 'Criminal Defense',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport5.png',
    },
    {
      'name': 'Lawyer 6',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport6.png',
    },
    {
      'name': 'Lawyer 7',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport7.png',
    },
    {
      'name': 'Lawyer 8',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport8.png',
    },
    {
      'name': 'Lawyer 9',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport9.png',
    },
    {
      'name': 'Lawyer 10',
      'specification': 'Family Law',
      'rating': Random().nextDouble() * 5,
      'image': 'assets/images/passport10.png',
    },
  ];

  List<bool> isFavorite = List.generate(10, (index) => false);
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

  void filterByLawyerType(List<bool> typeSelection) {
    List<String> selectedTypes = [];
    for (int i = 0; i < typeSelection.length; i++) {
      if (typeSelection[i]) {
        selectedTypes.add(lawyerTypes[i]);
      }
    }

    setState(() {
      if (selectedTypes.isEmpty || selectedTypes.contains('All')) {
        filteredProfiles = List.from(lawyerProfiles);
      } else {
        filteredProfiles = lawyerProfiles
            .where((profile) => selectedTypes.contains(profile['specification']))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFdcbaff),
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              List<bool> typeSelection = List<bool>.filled(lawyerTypes.length, false);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Text('Filter by Type'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            lawyerTypes.length,
                            (index) => CheckboxListTile(
                              title: Text(lawyerTypes[index]),
                              value: typeSelection[index],
                              onChanged: (value) {
                                setState(() {
                                  typeSelection[index] = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              filterByLawyerType(typeSelection);
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Color(0xFFB884D1),
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
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged: filterProfiles,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
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
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isFavorite[index] = !isFavorite[index];
                                          });
                                        },
                                        child: Icon(
                                          isFavorite[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite[index]
                                              ? Colors.red
                                              : Colors.grey,
                                          size: constraints.maxWidth * 0.06,
                                        ),
                                      ),
                                      SizedBox(width: constraints.maxWidth * 0.02),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(filteredProfiles[index]['image']),
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
                                            filteredProfiles[index]['specification'] as String,
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
