import 'package:flutter/material.dart';
import 'package:woosignal/models/response/system_status.dart' as systemStatus;
import 'package:woosignal/woosignal.dart';
import 'package:woosignal/models/response/payment_gateway.dart';

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

    PaymentGateWay coupons = await wooSignal
        .updatePaymentGateway(id: 'bacs', data: {'enabled': false});
    print(coupons.enabled);

    setState(() {
      _productName = coupons.enabled.toString();
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
