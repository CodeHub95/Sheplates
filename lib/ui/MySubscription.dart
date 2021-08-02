import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/ui/ActiveWidget.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/PastWidget.dart';
import 'package:flutter_sheplates/ui/PastWidgetWithTab.dart';

class MySubscription extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MySubscription> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Color(0xffF15C22),
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "ACTIVE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "PAST",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            title: Center(
                child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "My SUBSCRIPTIONS",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ))),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Image.asset(
                  "assets/left_menu.png",
                  fit: BoxFit.fill,
                  // color: Colors.transparent,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), //stops data reloading and scrolling
            children: [ActiveWidget(), PastWidgetWithTabs()],
          ),
        ),
      ),
    );
  }
}
