import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheplates/ui/ActiveWidgetWithTab.dart';
import 'package:flutter_sheplates/ui/DrawerScreen.dart';
import 'package:flutter_sheplates/ui/PastWidgetWithTab.dart';
import 'package:flutter_sheplates/modals/response/MySubscriptions.dart';
import 'package:flutter_sheplates/Utils/app_defaults.dart';
import 'package:flutter_sheplates/Utils/NetworkUtils.dart';

class MySubscription extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MySubscription> {
  @override
  initState() {
    fetchMySubscriptions();
    super.initState();
  }

  MySubscriptionResponse subscriptionData;
  Future<void> fetchMySubscriptions() async {
    String token = await SharedPrefHelper().getWithDefault("token", "");
    var res = await NetworkUtil().get("user/my-subscription", token: token);
    setState(() {
      return subscriptionData = MySubscriptionResponse.fromJson(res);
    });
    print("**************** subscription data ***************");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: subscriptionData == null
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
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
                  // children: [ActiveWidget(), PastWidgetWithTabs()],
                  children: [
                    ActiveWidgetWithTab(subscriptionData.data.activeSubscription),
                    PastWidgetWithTabs(subscriptionData.data.pastSubscription)
                  ],
                ),
              ),
            ),
    );
  }
}
