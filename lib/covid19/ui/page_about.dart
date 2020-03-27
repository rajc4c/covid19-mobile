import 'package:flutter/material.dart';
import 'package:openspaces/common/utils.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  List<String> supporterLogos = [
    "assets/images/pean_logo.jpg",
    "assets/images/c4c_logo.jpg",
    "assets/images/naxa_logo.png",
    "assets/images/soch_nepal.png",
    "assets/images/ihrr.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBar(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/images/np_logo.png"),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "हाम्रो स्वास्थ्य एप नेपाल सरकार, स्वास्थ्य तथा जनसंख्या मन्त्रालयले तयार गरेको हो। यस एपमार्फत मन्त्रालयले महत्वपूर्ण जानकारी, सूचना तथा कुनै माहामारीको समयमा आपतकालिन तथ्यांक, सम्पर्क नम्बर र अन्य जानकारी सर्वसाधारणमा संप्रेषण गर्नेछ।यस एप मन्त्रालयको रहोबरमा निम्न संस्थाहरुको प्राविधिक र निःशुल्क सहयोगमा तयार गरिएको हो।",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "सहयोगः",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/pean_logo.jpg")),
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/soch_nepal.jpg")),
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/ihrr.jpg")),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "प्राविधिक सहयोगः",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Utils.launchURL("https://codeforcore.com/");
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset("assets/images/c4c_logo.jpg")),
                  ),
                  InkWell(
                    onTap: () {
                      Utils.launchURL("http://naxa.com.np/home/");
                    },
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset("assets/images/naxa_logo.jpg")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
