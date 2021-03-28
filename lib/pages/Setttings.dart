import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:to_do_app/ConstVar.dart';
import 'package:to_do_app/ThemeMode.dart';
import 'package:to_do_app/pages/AboutUs.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: ConstantVars.yuseiMagic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 70.0,
            ),

            // mode card >>>>>>>>>>>>>>>>>>>>
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontFamily: ConstantVars.yuseiMagic,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Consumer<ThemeNotifier>(
                  builder: (context, ThemeNotifier notifier, child) {
                    return Switch(
                      activeColor: Colors.blue,
                      inactiveTrackColor: Colors.red,
                      value: notifier.darhTheme,
                      onChanged: (value) {
                        setState(() {
                          // your code is here >>>>
                          notifier.setTheme();
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            // share app card
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: ListTile(
                title: Text(
                  "Share App",
                  style: TextStyle(
                    fontFamily: ConstantVars.yuseiMagic,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.share,
                  color: Theme.of(context).primaryColor,
                  size: 27,
                ),
                onTap: () {
                  // your code is here >>>
                  _shareApp(context);
                },
              ),
            ),
            // rate us card >>>>>>>>>>>>
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: ListTile(
                title: Text(
                  "Rate Us",
                  style: TextStyle(
                    fontFamily: ConstantVars.yuseiMagic,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.star_rate,
                  color: Theme.of(context).primaryColor,
                  size: 27,
                ),
                onTap: () {
                  // your rating app  code is here >>>>
                  final String url =
                      "https://play.google.com/store/apps/details?id=com.javcoder.to_do_app&referrer=utm_source%3Dgoogle";
                  _launchUrl(url);
                },
              ),
            ),

            // about us card
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              child: ListTile(
                title: Text(
                  "About Us",
                  style: TextStyle(
                    fontFamily: ConstantVars.yuseiMagic,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 27,
                ),
                onTap: () {
                  //your code is here >>>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // this method is used to share app with your friends
  void _shareApp(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final String title =
        "Todo app,please,do not forget share our app with your friends the link on google play>>> :";
    //final String description ="please,do not forget share our app with your friends";
    final String url =
        "https://play.google.com/store/apps/details?id=com.javcoder.to_do_app&referrer=utm_source%3Dgoogle";

    Share.share("${title + url}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could not launch $url";
    }
  }
}
