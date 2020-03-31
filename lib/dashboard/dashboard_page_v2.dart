import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardPageV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'कोभिड-१९ ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(
                          text: 'तथ्याङ्क', style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                    Text(" विश्वभरीमा",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold))
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("१२४४५७",
                                  style: TextStyle(
                                      fontSize: 22,fontWeight: FontWeight.bold, color: Color(0xff0d49ef))),
                              Text(
                                "संक्रमित",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("१२४४५७",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff00ad13))),
                              Text(
                                "निको भएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("१२४४५७",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffef1919))),
                              Text(
                                "मृत्यु भएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ]),
                      ]),
                  Row(
                    children: <Widget>[
                      Text("नेपालको पछिल्लो तथ्याङ्क",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffe9ecff),
                            ),
                            padding: EdgeInsets.only(left: 15, top: 6),
                            constraints: BoxConstraints.expand(
                                width: 105.0, height: 60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("१७",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.black)),
                                Text(
                                  "परीक्षण गरीएको",
                                  style: TextStyle(fontSize: 11),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffe5f7e6),
                            ),
                            padding: EdgeInsets.only(left: 15, top: 6),
                            constraints: BoxConstraints.expand(
                                width: 105.0, height: 60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("२००",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.black)),
                                Text(
                                  "संक्रमण नदेखिएको",
                                  style: TextStyle(fontSize: 11),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffffebec),
                            ),
                            padding: EdgeInsets.only(left: 15, top: 6),
                            constraints: BoxConstraints.expand(
                                width: 105.0, height: 60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("७",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.black)),
                                Text(
                                  "संक्रमण देखिएको",
                                  style: TextStyle(fontSize: 11),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffe9ecff),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("४",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "आइसोलेसनमा",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffe5f7e6),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("१",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "निको भएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffffebec),
                          ),
                          padding: EdgeInsets.only(left: 15, top: 6),
                          constraints:
                              BoxConstraints.expand(width: 105.0, height: 60.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("०",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              Text(
                                "मृत्यु भएको",
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffeeeeee),
              ),
              padding: EdgeInsets.all(20),
              constraints:
                  BoxConstraints.expand(width: double.infinity, height: 282),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          left: 18, top: 15, right: 10, bottom: 15),
                      constraints: BoxConstraints.expand(
                          width: double.infinity, height: 70),
                      child: Row(children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/Mask Group 17.png'),
                          width: 52,
                          height: 52,
                        ),
                        Text(
                          "कोभिड-१९ को लक्षणहरु आफै मुल्यांकन गर्नुहोस्",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right, color: Colors.black)
                      ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          left: 18, top: 15, right: 10, bottom: 15),
                      constraints: BoxConstraints.expand(
                          width: double.infinity, height: 70),
                      child: Row(children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/Mask Group 18.png'),
                          width: 52,
                          height: 52,
                        ),
                        Text(
                          "नक्सा हेर्नुहोस्",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right, color: Colors.black)
                      ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          left: 18, top: 15, right: 10, bottom: 15),
                      constraints: BoxConstraints.expand(
                          width: double.infinity, height: 70),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(
                              image:
                                  AssetImage('assets/images/Mask Group 19.png'),
                              width: 52,
                              height: 52,
                            ),
                            Text(
                              "उपयोगी जानकारी",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black),
                            
                          ]),
                    )
                  ]),
            ),
            Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffe9ecff),
              ),
              padding: EdgeInsets.all(20),
              constraints:
                  BoxConstraints.expand(width: double.infinity, height: 213),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/Viber.png'),
                    width: 61.17,
                    height: 28.71,
                  ),
                  Text("MOHP Nepal COVID-19",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                          SizedBox(
                            height: 26,
                          ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.call, color: Colors.red),
                        Text(
                          "कोभिड-१९ हटलाईन",
                          style: TextStyle(color: Colors.red),
                        )
                      ]),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: '9851-255-834',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue)),
                        TextSpan(
                            text: ' | ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        TextSpan(
                            text: '9851-255-834',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue)),
                        TextSpan(
                            text: ' | ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        TextSpan(
                            text: '9851-255-834',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                  Text("(8am-8pm)"),
                  SizedBox(
                            height: 15,
                          ),
                  Text("1115",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.blue)),
                  Text("(6am-10pm)")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
