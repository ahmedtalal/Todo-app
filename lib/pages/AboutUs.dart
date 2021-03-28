import 'package:flutter/material.dart';
import 'package:to_do_app/ConstVar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                  ),
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: ConstantVars.yuseiMagic,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You can contact us from these links in below",
                  style: TextStyle(
                    fontFamily: ConstantVars.yuseiMagic,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // facebook card ???????????????????????
              Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          "Facebook",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: ConstantVars.yuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          String url = "https://www.facebook.com/ahmd.talal.5";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    // instgram card ??????????????????????
                    Card(
                      child: ListTile(
                        title: Text(
                          "Instgram",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: ConstantVars.yuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          String url =
                              "https://www.instagram.com/ahmedtalal98/";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "LinkedIn",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: ConstantVars.yuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          String url =
                              "https://www.linkedin.com/in/ahmed-talal-211a47179/";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Github",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: ConstantVars.yuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          String url =
                              "https://github.com/ahmedtalal?tab=repositories";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "gmail",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: ConstantVars.yuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          const String url =
                              "https://mail.google.com/mail/u/0/#inbox";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could not launch $url";
    }
  }
}
