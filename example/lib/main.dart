import 'package:flutter/material.dart';
// import 'package:woosignal/models/response/products.dart';
import 'package:woosignal/models/response/customer_batch.dart';
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

    // Customers coupons = await wooSignal.retrieveCustomer(id: 2);
    // Customers coupons =
    //     await wooSignal.updateCustomer(2, data: {'first_name': 'Shahryar'});
    // Customers coupons = await wooSignal.deleteCustomer(29, data: {
    //   'force': true,
    // });
    CustomerBatch coupons = await wooSignal.batchCustomers(
      data: {
        "create": [
          {
            "email": "testexamole@example.com",
            "first_name": "John",
            "last_name": "Doe",
            "username": "test.testexamole",
            "billing": [
              {
                "first_name": "John",
                "last_name": "Doe",
                "company": "",
                "address_1": "969 Market",
                "address_2": "",
                "city": "San Francisco",
                "state": "CA",
                "postcode": "94103",
                "country": "US",
                "email": "john.testexamole@example.com",
                "phone": "(555) 555-5555"
              }
            ],
            "shipping": [
              {
                "first_name": "John",
                "last_name": "Doe",
                "company": "",
                "address_1": "969 Market",
                "address_2": "",
                "city": "San Francisco",
                "state": "CA",
                "postcode": "94103",
                "country": "US"
              }
            ]
          },
          {
            "email": "testexamole.silva2test@example.com",
            "first_name": "João",
            "last_name": "Silva",
            "username": "testexamole.silva5",
            "billing": [
              {
                "first_name": "João",
                "last_name": "Silva",
                "company": "",
                "address_1": "Av. Brasil, 432",
                "address_2": "",
                "city": "Rio de Janeiro",
                "state": "RJ",
                "postcode": "12345-000",
                "country": "BR",
                "email": "testexamole.silva@example.com",
                "phone": "(55) 5555-5555"
              }
            ],
            "shipping": [
              {
                "first_name": "João",
                "last_name": "Silva",
                "company": "",
                "address_1": "Av. Brasil, 432",
                "address_2": "",
                "city": "Rio de Janeiro",
                "state": "RJ",
                "postcode": "12345-000",
                "country": "BR"
              }
            ]
          }
        ],
        "update": [
          {
            "id": "2",
            "billing": {"phone": "(55) 5555-5555"}
          }
        ],
        "delete": [31]
      },
    );

    print(coupons.create[0].email);

    setState(() {
      _productName = coupons.create[0].email;
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
