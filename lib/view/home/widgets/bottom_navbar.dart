import 'package:flutter/material.dart';
import 'package:netflix_app/view/home/HomeScreen.dart';
import 'package:netflix_app/view/home/downloads.dart';
import 'package:netflix_app/view/new_hot/new_hot_screen.dart';

class NetflixBottomNav extends StatefulWidget {
  const NetflixBottomNav({Key? key}) : super(key: key);

  @override
  State<NetflixBottomNav> createState() => _NetflixBottomNavState();
}

class _NetflixBottomNavState extends State<NetflixBottomNav> {
  final pages = [
    const HomeScreen(),
    const DownloadsPage(),
    const NewHotScreen(),
    const HomeScreen(),
    const DownloadsPage(),
  ];

  var selectedIndex = 0;

  Color selectedColor = Colors.white;
  Color unselectedColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              IconButton(
                icon:  Icon(
                  Icons.home,
                  color: selectedIndex==0? selectedColor : unselectedColor,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
              ),
              Text(
                'Home',
                style: TextStyle(fontSize: 11,color: selectedIndex==0? selectedColor : unselectedColor),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                icon:  Icon(
                  Icons.collections,
                  color: selectedIndex==1? selectedColor : unselectedColor,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
              ),
              Text(
                'Games',
                style: TextStyle(fontSize: 11, color: selectedIndex==1? selectedColor : unselectedColor,),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                icon:  Icon(
                  Icons.color_lens,
                  color: selectedIndex==2? selectedColor : unselectedColor,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
              ),
              Text(
                'New & Hot',
                style: TextStyle(fontSize: 10 ,color: selectedIndex==2? selectedColor : unselectedColor,),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                icon:  Icon(
                  Icons.emoji_emotions,
                 color: selectedIndex==3? selectedColor : unselectedColor,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
              ),
              Text(
                'Fast Laughs',
                style: TextStyle(fontSize: 10, color: selectedIndex==3? selectedColor : unselectedColor,),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                icon:  Icon(
                  Icons.download,
                   color: selectedIndex==4? selectedColor : unselectedColor,
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                },
              ),
              Text(
                'Downloads',
                style: TextStyle(fontSize: 10, color: selectedIndex==4? selectedColor : unselectedColor,),
              )
            ],
          )
        ]),
      ),
    );
  }
}
