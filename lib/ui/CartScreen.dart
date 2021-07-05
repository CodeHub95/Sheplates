import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo_home.png", fit: BoxFit.fill),
              Text('Cart', style: TextStyle(color: Colors.black, fontSize: 17)),
            ],
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    child: Text("8"),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                  height: MediaQuery.of(context).size.height * .55,
                  width: MediaQuery.of(context).size.width - 15,
                  // color: Colors.tealAccent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        buildCartItem(
                          mealTitle: "Porrdesh @ Rs. 60",
                          mealDesc: "(Qty: 1, Days: 1, Time: 07:00 AM)",
                          mealAmount: "60",
                        ),
                        buildCartItem(
                          mealTitle: "Porrdesh @ Rs. 60",
                          mealDesc: "(Qty: 1, Days: 1, Time: 07:00 AM)",
                          mealAmount: "60",
                        ),
                        buildCartItem(
                          mealTitle: "Porrdesh @ Rs. 60",
                          mealDesc: "(Qty: 1, Days: 1, Time: 07:00 AM)",
                          mealAmount: "60",
                        ),
                        buildCartItem(
                          mealTitle: "Porrdesh @ Rs. 60",
                          mealDesc: "(Qty: 1, Days: 1, Time: 07:00 AM)",
                          mealAmount: "60",
                        ),
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Item Total", style: TextStyle(fontSize: 17)),
                                Text("300", style: TextStyle(fontSize: 17)),
                              ],
                            ),
                            SizedBox(height: 7),
                            Container(color: Colors.grey, height: .5),
                            SizedBox(height: 5),
                          ],
                        ),
                        buildOtherDetails("Delivery", "100"),
                        buildOtherDetails("Taxes", "2.2"),
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text("400", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(color: Colors.grey, height: .5),
                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Colors.white,
                  color: Colors.grey[50],
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text("ORDER SUMMARY", style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.redAccent,
                      child: Text("Proceed to buy", style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.white,
                      child: Text("Back to plans", style: TextStyle(color: Colors.redAccent)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  buildCartItem({String mealTitle, String mealDesc, String mealAmount}) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mealTitle,
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 4),
                    Text(mealDesc, style: TextStyle(color: Colors.grey, fontSize: 14))
                  ],
                ),
                SizedBox(width: 10),
                Icon(Icons.delete_outline, size: 30, color: Colors.grey),
              ],
            ),
            Text(mealAmount, style: TextStyle(fontSize: 17))
          ],
        ),
        SizedBox(height: 10),
        Container(color: Colors.grey, height: .5),
      ],
    );
  }

  buildOtherDetails(String name, String amount) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(padding: EdgeInsets.only(right: 18), child: Text(name, style: TextStyle(fontSize: 17))),
                    Container(
                        width: 15,
                        height: 15,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1))),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text("i", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(amount, style: TextStyle(fontSize: 17)),
          ],
        ),
        SizedBox(height: 7),
        Container(color: Colors.grey, height: .5),
        SizedBox(height: 5),
      ],
    );
  }
}
