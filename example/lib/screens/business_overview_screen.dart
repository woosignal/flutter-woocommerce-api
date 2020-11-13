import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_maintained/sms.dart';
import '../providers/auth.dart';
import '../providers/school.dart';

class BusinessOverViewScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          Provider.of<Auth>(context, listen: false).schoolName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logOut();
            },
            child: Text('Log Out'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: FutureBuilder(
          future: Records().getMessages(Provider.of<Auth>(context).schoolId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var dataOfApi = snapshot.data['records'][index];

                  SmsSender sender = new SmsSender();
                  String address = dataOfApi['Contact'];
                  sender.sendSms(SmsMessage(
                    address,
                    dataOfApi['Message'],
                  ));
                  return Container(
                    height: 100,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(dataOfApi['Message']),
                          subtitle: Text(dataOfApi['Contact']),
                          trailing: Text('Sent'),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(dataOfApi['id']),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data['records'].length,
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
