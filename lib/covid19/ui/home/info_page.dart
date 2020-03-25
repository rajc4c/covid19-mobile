import 'package:flutter/material.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(child: Text("FAQ", style: TextStyle(fontSize: 16.0, color: Colors.black),), onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaqPage()));
                },)),
            SizedBox(height: 8.0,),
            Container( decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(child: Text("Situation Report", style: TextStyle(fontSize: 16.0, color: Colors.black),),)),
            SizedBox(height: 8.0,),
            Container( decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(child: Text("Safety Guidelines", style: TextStyle(fontSize: 16.0, color: Colors.black),),)),
            SizedBox(height: 8.0,),
            Container( decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: FlatButton(child: Text("Press Release", style: TextStyle(fontSize: 16.0, color: Colors.black),),))
          ],
        ),
      );
  }
}
