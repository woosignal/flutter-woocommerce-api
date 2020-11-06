import 'package:flutter/material.dart';
import 'package:woosignal/models/response/products.dart';
import 'package:woosignal/models/response/coupon.dart';
import 'package:woosignal/woosignal.dart';
import 'package:woosignal/models/response/coupon_batch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WooSignal Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WooSignal Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _productName = "";
  // CONFIG FOR WOOSIGNAL
  var wsConfig = {
    "appKey":
        "app_affb6434339b34443a297c2e40a3edab7102137e6d67de9abfe612b749bd",
    "debugMode": true
  };

  _incrementCounter() async {
    // CREATING AN INSTANCE
    WooSignal wooSignal = await WooSignal.getInstance(config: wsConfig);

    // Coupon coupons = await wooSignal.batchCoupon(data: {"create":"data"});
    CouponBatch couponBatch = await wooSignal.batchCoupon(
      data: {
        "create": [
          {
            "code": "15off",
            "discount_type": "percent",
            "amount": "20",
            "individual_use": "true",
            "exclude_sale_items": "true",
            "minimum_amount": "100.00"
          }
        ],
        "update": [
          {"id": "518", "minimum_amount": "100.00"}
        ],
        "delete": [517],
      },
    );

    print(couponBatch.create[0].id);

    setState(() {
      _productName = couponBatch.create[0].id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WooCommerce product :',
            ),
            Text(
              '$_productName',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.lightbulb_outline),
      ),
    );
  }
}
