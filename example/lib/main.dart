import 'package:flutter/material.dart';
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
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _productName = "";

  Future<void> _incrementCounter() async {
    // CREATING AN INSTANCE FOR WOOSIGNAL
    await WooSignal.instance.init(appKey: "your app key");

    List<Product> products = await WooSignal.instance.getProducts();
    if (products.isNotEmpty) {
      _productName = products[0].name ?? "";
    }
    setState(() {});
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
            Text('Tap the light bulb to get a product'),
            if (_productName != "")
              Text(
                'WooCommerce product :\n $_productName',
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
