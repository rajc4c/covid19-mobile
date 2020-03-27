import 'package:flutter/material.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  List<String> supporterLogos = [
    "assets/images/pean_logo.jpg",
    "assets/images/naxa_logo.png",
    "assets/images/c4c_logo.jpg",
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
              ListTile(
                leading: Image.asset(supporterLogos[0], height: 56.0, width: 56.0,),
                title: Text("सुचना तथा तथ्यांक जम्मा गर्ने सहयोगः"),
                subtitle: Text("PEAN"),
              ),

              SizedBox(height: 16.0,),
              Text("प्राविधिक सहयोगः", style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),),

              ListTile(
                leading: Image.asset(supporterLogos[2], height: 56.0, width: 56.0,),
                title: Text("Code for Core inovation"),
//                subtitle: Text("PEAN"),
              ),
              ListTile(
                leading: Image.asset(supporterLogos[1], height: 56.0, width: 56.0,),
                title: Text("Naxa pvt. ltd."),
//                subtitle: Text("PEAN"),
              ),
//              ListTile(
//                title: Text(""),
//                subtitle: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text("NAXA"),
//                    SizedBox(
//                      height: 4.0,
//                    ),
//                    Text("Code for Core Innovation")
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 16.0,
//              ),
//              Container(
//                height: 150.0,
//                child: ListView(
//                  scrollDirection: Axis.horizontal,
//                  children: List<Widget>.generate(
//                      supporterLogos.length,
//                      (index) => Container(
//                          width: 150.0,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular((16.0))),
//                          child: Card(
//                            child: Image.asset(supporterLogos[index]),
//                          ))),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
