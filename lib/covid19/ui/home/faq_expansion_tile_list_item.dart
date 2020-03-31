import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/covid19/ui/home/page_faq.dart';

import '../../colors.dart';

class ExpansionTileListItemWidget extends StatefulWidget{

  int pos;
  Faq faq;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExpansionTileListItemWidgetState();
  }

  ExpansionTileListItemWidget(this.pos, this.faq);

}

class ExpansionTileListItemWidgetState extends State<ExpansionTileListItemWidget> {
  bool isExpanding = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExpansionTile(

      title: Text("${widget.pos+1}. ${widget.faq.title}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14.0),),

      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(widget.faq.answers, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12.0, height: 1.5, letterSpacing: 1.5),),
        ),
        SizedBox(height: 10,)
      ],

      trailing:  ClipOval(
        child: Container(
          height: 34.0,
          width: 34.0,
          color: OpenSpaceColors.white,
          child: Icon(
            isExpanding? Icons.expand_less:Icons.expand_more,
            color: Colors.black54,
          ),
        ),
      ),
      onExpansionChanged: (expanding){
        setState(() {isExpanding = expanding;
        });
      },
    );;
  }
}