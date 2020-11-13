import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
// import 'package:haider_app/screens/register_screen.dart';
import '../widgets/button.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Top Section
            Expanded(
              child: buildTopSection(MediaQuery.of(context).size.height * 0.48,
                  MediaQuery.of(context).size.width * 1),
            ),
            //Bottom Section
            Expanded(
              child: buildBottomSection(
                  MediaQuery.of(context).size.height * 0.46,
                  MediaQuery.of(context).size.width * 1,
                  context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTopSection(double height, double width) {
  return Container(
    // color: Colors.blue,
    height: height,
    width: width,
    child: Image.asset('assets/Logo.png'),
  );
}

Widget buildBottomSection(double height, double width, context) {
  return Container(
    height: height,
    width: width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          name: 'Login',
          onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
        ),
        AppButton(
          name: 'Register',
          onPressed: () {},
        ),
      ],
    ),
  );
}
