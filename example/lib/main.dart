// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:haider_app/screens/business_overview_screen.dart';
// import 'package:haider_app/screens/splash_screen.dart';

// import './screens/login_screen.dart';

// import './providers/auth.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(
//             create: (context) => Auth(),
//           ),
//         ],
//         child: Consumer<Auth>(builder: (ctx, auth, _) {
//           // print(auth.isAuth);
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: '''Haider's App''',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.white,
//               primaryColor: Color.fromRGBO(124, 116, 146, 1),
//               buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//               appBarTheme: AppBarTheme(
//                   color: Colors.white,
//                   elevation: 0.0,
//                   iconTheme:
//                       IconThemeData(color: Color.fromRGBO(124, 116, 146, 1))),
//             ),
//             home: auth.isAuth
//                 ? BusinessOverViewScreen()
//                 : FutureBuilder(
//                     builder: (context, authResultSnapshot) {
//                       print(auth.isAuth);
//                       return authResultSnapshot.connectionState ==
//                               ConnectionState.waiting
//                           ? SplashScreen()
//                           : LoginScreen();
//                     },
//                     future: auth.tryAutoLogin(),
//                   ),
//             routes: {
//               LoginScreen.routeName: (ctx) => LoginScreen(),
//               // RegisterScreen.routeName: (ctx) => RegisterScreen(),
//               BusinessOverViewScreen.routeName: (ctx) =>
//                   BusinessOverViewScreen()
//             },
//           );
//         }));
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sms_maintained/sms.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(
//     MaterialApp(
//       home: SendSmsScreen(),
//     ),
//   );
// }

// class SendSmsScreen extends StatelessWidget {
//   final SmsSender sender = SmsSender();
//   final SmsMessage message = SmsMessage('03009640742', '_body');
//   final List<SmsMessage> smsList = [
//     SmsMessage('03009750742', 'Random'),
//     SmsMessage('03008750742', 'Kaleem'),
//     SmsMessage('03056750742', 'Shahryar'),
//     SmsMessage('03127750742', 'Shahryar Zong')
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: ListView.builder(
//           itemCount: smsList.length,
//           itemBuilder: (context, index) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: () {
//                       sender.sendSms(smsList[index]);
//                     },
//                   ),
//                   StreamBuilder<SmsMessageState>(
//                     key: GlobalKey(debugLabel: 'String $index'),
//                     // initialData: SmsMessageState.None,
//                     builder: (context, snapshot) {
//                       if (snapshot.data == SmsMessageState.Sent) {
//                         return Text('Message Sent');
//                       }
//                       if (snapshot.data == SmsMessageState.Delivered) {
//                         return Text('Message Delivered');
//                       }
//                       if (snapshot.data == SmsMessageState.Sending) {
//                         return Text('Sending');
//                       }
//                       if (snapshot.data == SmsMessageState.Fail)
//                         return Text('Sending Failed');
//                       return Text('Error');
//                     },
//                     stream: smsList[index].onStateChanged,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:woosignal/models/response/products.dart';
import 'package:woosignal/models/response/coupon.dart';
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
  // CONFIG FOR WOOSIGNAL
  var wsConfig = {
    "appKey":
        "app_affb6434339b34443a297c2e40a3edab7102137e6d67de9abfe612b749bd",
    "debugMode": true
  };

  _incrementCounter() async {
    // CREATING AN INSTANCE
    WooSignal wooSignal = await WooSignal.getInstance(config: wsConfig);

    Coupon coupons = await wooSignal.retrieveCoupons(id: 511);
    print(coupons.id);

    setState(() {
      _productName = coupons.id.toString();
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
