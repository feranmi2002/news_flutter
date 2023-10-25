import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Function()? onErrorTapped;

  ErrorView({required this.onErrorTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "An Error Occurred",
            style: TextStyle(color: Colors.red),
          ),
          ElevatedButton(onPressed: onErrorTapped, child: Text("RETRY"))
        ],
      ),
    );
  }
}
