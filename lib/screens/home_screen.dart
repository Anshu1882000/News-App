
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './business_screen.dart';
import './entertainment_screen.dart';
import './health_screen.dart';
import './science_screen.dart';
import './sports_screen.dart';
import './tech_screen.dart';
import 'general_news_screen.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _screens = [
    GeneralNewsScreen(),
    SportsScreen(),
    EntertainmentScreen(),
    BusinessScreen(),
    HealthScreen(),
    ScienceScreen(),
    TechScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              title: Text(
                "News App",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              // leading: IconButton(
              //   icon: Icon(
              //     Icons.search_rounded,
              //     size: 40,
              //     color: Colors.black,
              //   ),
              //   onPressed: null, //() =>
              //   // {Navigator.of(context).pushNamed(SearchScreen.routeName)},
              // ),
              
            ),
          ],
          body: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: icons.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 15,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Center(
                        child: Text(
                          icons[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _screens[_selectedIndex]
            ],
          ),
        ),
      ),
    );
  }
}
