import 'package:flutter/material.dart';
import 'package:openspaces/common/constants.dart';
import 'package:openspaces/common/utils.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/covid19/ui/home/page_fact_check.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/covid19/ui/home/page_safety_guidelines.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBarText(title: "उपयोगी जानकारी"),
      backgroundColor: OpenSpaceColors.defaultBackground,
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 2.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: OpenSpaceColors.white, ),
                  color: OpenSpaceColors.white,
                  borderRadius:BorderRadius.all(Radius.circular(8.0))
                ),
                width: MediaQuery.of(context).size.width,
//                height: 48.0,
                child: ListTile(
                  title: Text(
                    "धेरै सोधिने प्रश्नहरु",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black87,),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FaqPage()));
                  },
                )),
            SizedBox(
              height: 8.0,
            ),

            Container(
                padding: EdgeInsets.only(top: 2.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: OpenSpaceColors.white, ),
                    color: OpenSpaceColors.white,
                    borderRadius:BorderRadius.all(Radius.circular(8.0))
                ),
                width: MediaQuery.of(context).size.width,
//                height: 48.0,
                child: ListTile(
                  title: Text(
                    "स्थिति प्रतिवेदनहरु",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black87,),
                  onTap: () {
                    Utils.launchURL(situationReportUrl);
                  },
                )),
            SizedBox(
              height: 8.0,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SafetyGuidelinesPage()));
                  },
                  child: Text(
                    " आफू र अरुलाई कसरी सुरक्षित राख्ने",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                )),
//            SizedBox(
//              height: 8.0,
//            ),
//            Container(
//                decoration: BoxDecoration(
//                    border: Border.all(width: 1.0, color: Colors.black)),
//                width: MediaQuery.of(context).size.width,
//                height: 48.0,
//                child: FlatButton(
//                  child: Text(
//                    "प्रेस रिलिजहरु",
//                    style: TextStyle(fontSize: 16.0, color: Colors.black),
//                  ),
//                )),
            SizedBox(
              height: 8.0,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FactCheckPage()));
                    },
                  child: Text(
                    "भ्रम र यथार्थ",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
