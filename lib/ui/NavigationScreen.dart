import 'package:covid19/ui/HomeScreen.dart';
import 'package:covid19/ui/SearchScreen.dart';
import 'package:covid19/utils/ProjectTheme.dart';
import 'package:flutter/material.dart';

class NavigationScreens extends StatefulWidget {
  @override
  _NavigationScreensState createState() => _NavigationScreensState();
}

class _NavigationScreensState extends State<NavigationScreens> {
  int _currentIndex = 0;
  List<Widget> _children = [HomeScreen(), SearchScreen()];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          // notchMargin: 80,
          child: Container(
            height: _height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                //   backgroundColor: ProjectTheme.projectPrimaryColor,
                backgroundColor: Ptheme.primaryThemeColor,
                selectedLabelStyle: TextStyle(
                  fontSize: 0,
                ),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 25,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    label: '',
                  ),
                ],
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut);
                  });
                },
              ),
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _children,
        ));
  }
}
