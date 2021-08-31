import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/news_screen.dart';
import '../screens/search_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _icons = [
    'All',
    'Sports',
    'Entertainment',
    'Buisness',
    'Health',
    'Science',
    'Tech'
  ];

  int _selectedIndex = 0;

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
              leading: IconButton(
                icon: Icon(Icons.search_rounded, size: 40, color: Colors.black,), onPressed: () => {
                  Navigator.of(context).pushNamed(SearchScreen.routeName)
                }),
            ),
          ],
          body: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _icons.length,
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
                          _icons[index],
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
              NewsScreen(index: _selectedIndex)
            ],
          ),
        ),
      ),
    );
  }
}
