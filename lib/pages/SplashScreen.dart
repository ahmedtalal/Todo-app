import 'package:flutter/material.dart';
import 'package:to_do_app/ConstVar.dart';
import 'package:to_do_app/pages/TasksList.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            "Get started",
            style: TextStyle(
              fontSize: 16,
              fontFamily: ConstantVars.yuseiMagic,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TasksList()));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            Container(
              height: height * 0.4,
              width: width * 0.8,
              child: Image(
                image: AssetImage("assets/images/note2.png"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "create your own tasks",
              style: TextStyle(
                fontSize: 20,
                fontFamily: ConstantVars.yuseiMagic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
