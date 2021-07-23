import 'package:flutter/material.dart';
import 'Feedback.dart';

class SubscriptionListForFeedback extends StatelessWidget {
  const SubscriptionListForFeedback({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Text(
              "Delivered meals",
              style: TextStyle(color: Colors.black, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * .1),
                Expanded(child: Container(color: Colors.grey, height: .5)),
                Text(
                  " Choose a meal for feedback",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                Expanded(child: Container(color: Colors.grey, height: .5)),
                SizedBox(width: MediaQuery.of(context).size.width * .1),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            height: MediaQuery.of(context).size.height * .7,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => FeedBack(subscriptionID: index + 1)));
                    },
                    leading: Icon(Icons.food_bank),
                    title: Text("Meal ${index + 1}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
