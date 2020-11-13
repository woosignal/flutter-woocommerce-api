import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final Function onPressed;
  // final BuildContext context;

  const AppButton({
    Key key,
    @required this.name,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 60,
      width: MediaQuery.of(context).size.width * 0.5,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Color.fromRGBO(124, 116, 146, 1),
        onPressed: onPressed,
        child: Text(name),
      ),
    );
  }
}
