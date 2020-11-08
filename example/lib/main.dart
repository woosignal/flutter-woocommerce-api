import 'package:flutter/material.dart';
// import 'package:woosignal/models/response/SaleReport.dart';
import 'package:woosignal/models/response/reports.dart';
// import 'package:woosignal/models/response/top_seller_report.dart';
import 'package:woosignal/woosignal.dart';

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

  _incrementCounter() async {
    // CONFIG FOR WOOSIGNAL
    var wsConfig = {
      "appKey":
          "app_affb6434339b34443a297c2e40a3edab7102137e6d67de9abfe612b749bd",
      "debugMode": true
    };

    // CREATING AN INSTANCE
    WooSignal wooSignal = await WooSignal.getInstance(config: wsConfig);

    // List<Reports> reports = await wooSignal.getReports();
    // List<SalesReports> reports = await wooSignal.getSaleReports();
    // List<TopSellerReport> reports = await wooSignal.getTopSellerReports();
    // List<TotalReport> reports = await wooSignal.getTotalCouponsReports();
    // List<TotalReport> reports = await wooSignal.getTotalCustomerReports();
    // List<TotalReport> reports = await wooSignal.getTotalOrderReports();
    // List<TotalReport> reports = await wooSignal.getTotalProductReports();
    // List<TotalReport> reports = await wooSignal.getTotalReviewReports();
    List<TotalReport> reports = await wooSignal.getTotalReviewReports();

    print(reports[0].name);

    setState(() {
      _productName = reports[0].name.toString();
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
