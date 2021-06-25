import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

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
            padding: EdgeInsets.only(right: 10),
            child: Stack(children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                },
              ),
              Expanded(
                child: Positioned(
                  right: 1,
                  top: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      child: Text("8"),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(height: 20),
              buildCartItem(),
              buildCartItem(),
              buildCartItem(),
              buildCartItem(),
              buildCartItem(),
              buildCartOtherDetails("Item Total", "300"),
              buildCartOtherDetails("Delivery", "100"),
              buildCartOtherDetails("Taxes", "2.2"),
              buildCartOtherDetails("Total", "400"),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: SizedBox(
                  height: 40,
                  width: 180,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.white,
                    child: Text("Proceed to buy", style: TextStyle(color: Colors.red)),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: SizedBox(
                  height: 40,
                  width: 180,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.white,
                    child: Text("Back to plans", style: TextStyle(color: Colors.red)),
                    onPressed: () {},
                  ),
                ),
              ),
              // SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCartOtherDetails(String name, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(amount),
        ],
      ),
    );
  }

  Padding buildCartItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Porrdes @ Rs. 40 (Qty-1, Days-1, 7:00)",
                style: TextStyle(color: Colors.black),
              ),
              Icon(Icons.delete),
              Text("60")
            ],
          ),
          buildCartOtherDetails("Packagign", "10"),
        ],
      ),
    );
  }
}
