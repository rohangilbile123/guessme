import 'package:flutter/material.dart';
import './game_screen.dart';
import './home_screen.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  final List<String> levels = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
    'Level 6',
    'Level 7',
    'Level 8',
    'Level 9',
    'Level 10',
  ];

  Set<String> clearedLevels = {};

  @override
  Widget build(BuildContext context) {
    final String category =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$category',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Image.asset('assets/bg.jpg', height: 50, width: 150),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    String levelName = levels[index];
                    bool isCleared = clearedLevels.contains(levelName);
                    bool isLocked = (!isCleared) &&
                        index > 0 &&
                        !clearedLevels.contains(levels[index - 1]);
                    return GestureDetector(
                      onTap: isLocked
                          ? null
                          : () async {
                              int score = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameScreen(),
                                ),
                              );

                              if (score >= 2) {
                                setState(() {
                                  clearedLevels.add(levels[index]);
                                });
                              }
                            },
                      child: LevelItem(levelName, isCleared, isLocked),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LevelItem extends StatelessWidget {
  final String levelName;
  final bool isCleared;
  final bool isLocked;

  LevelItem(this.levelName, this.isCleared, this.isLocked);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCleared ? Colors.transparent : Colors.black12,
          ),
          child: Icon(
            isCleared ? Icons.star : Icons.star_border,
            color: isCleared ? Colors.amber : Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Text(
          levelName,
          style: TextStyle(
            color: isLocked ? Colors.grey : Colors.black,
          ),
        ),
      ],
    );
  }
}
