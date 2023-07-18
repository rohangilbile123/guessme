import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categoryNames = [
    'Celebrity',
    'Place',
    'Country',
    'Logo',
    'Animal',
    'Sport ',
    'Landmarks',
    'Instruments',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              // Handle menu button tap
                            },
                          ),
                          Expanded(
                            child: Text(
                              'My App Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red),
                              Icon(Icons.favorite, color: Colors.red),
                              Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 500,
                    height: 250,
                    // Adjust the height as per your requirement
                    child: Image.asset('assets/banner.jpg'),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: List.generate(8, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/game',
                            arguments: categoryNames[index],
                          );
                        },
                        child: GridTile(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 40,
                            color: Colors.blue[200],
                            child: Center(
                              child: Text(categoryNames[index]),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  // Add your additional section here
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/game');
                      },
                      child: Text('Start Game'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
