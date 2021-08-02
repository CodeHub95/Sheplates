import 'package:flutter/material.dart';
import 'Feedback.dart';

class SubscriptionListForFeedback extends StatefulWidget {
  const SubscriptionListForFeedback({Key key}) : super(key: key);

  @override
  _SubscriptionListForFeedbackState createState() => _SubscriptionListForFeedbackState();
}

class _SubscriptionListForFeedbackState extends State<SubscriptionListForFeedback> {
  getProjectDetails() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text("Delivered meals", style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center),
        centerTitle: true,
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
            child: FutureBuilder(
              future: getProjectDetails(),
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
                  print('project snapshot data is: ${projectSnap.data}');
                  return Container();
                }
                return ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    // ProjectModel project = projectSnap.data[index];
                    return Column(
                      children: <Widget>[
                        // Widget to display the list of project
                      ],
                    );
                  },
                );
              },
            ),
            // child: ListView.builder(
            //   itemCount: 15,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: ListTile(
            //         onTap: () {
            //           Navigator.push(
            //               context, MaterialPageRoute(builder: (context) => FeedBack(subscriptionID: index + 1)));
            //         },
            //         leading: Icon(Icons.food_bank),
            //         title: Text("Meal ${index + 1}"),
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
