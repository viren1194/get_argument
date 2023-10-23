import 'package:flutter/material.dart';

class MyTabBarScreen extends StatefulWidget {
  @override
  State<MyTabBarScreen> createState() => _MyTabBarScreenState();
}

class _MyTabBarScreenState extends State<MyTabBarScreen> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text("become a member"),
                  Icon(Icons.close),
                ],
              ),
              SizedBox(
                height: 29,
              ),
              TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.green,
                // labelPadding: EdgeInsets.all(8),
                // padding: EdgeInsets.all(8),

                // labelPadding: EdgeInsets.all(15),
                tabs: [
                  Tab(
                    child: Stack(
                      // alignment: Alignment.topRight,
                      children: [
                        Text('Free plan'),
                        if (selectedTabIndex == 0)
                          Positioned(
                              left: 50, bottom: 6, child: Icon(Icons.done)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Stack(
                      // alignment: Alignment.topRight,
                      children: [
                        Text('Pro plan'),
                        if (selectedTabIndex == 1)
                          Positioned(
                              left: 45, bottom: 6, child: Icon(Icons.done)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Stack(
                      // alignment: Alignment.topRight,
                      children: [
                        Text('Enterprise plan'),
                        if (selectedTabIndex == 2)
                          Positioned(
                              left: 80, bottom: 6, child: Icon(Icons.done)),
                      ],
                    ),
                  ),
                ],
                onTap: (value) {
                  setState(() {
                    selectedTabIndex = value;
                  });
                },
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  children: [
                    Center(child: Text('Content for Tab 1')),
                    Center(child: Text('Content for Tab 2')),
                    Center(child: Text('Content for Tab 3')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
