import 'package:flutter/material.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar_faq.dart';

import 'expansion_tile_list_item.dart';

class ItemModel {
  bool isExpanded;
  String header;
  String body;

  ItemModel({this.isExpanded: false, this.header, this.body});
}

class FaqPage extends StatefulWidget {
  @override
  _FaqPage createState() => _FaqPage();
}

class _FaqPage extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: covidAppBar(),
      body: Container(
        color: Color(0xffeeeeee),
        padding: EdgeInsets.all(0),
        child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (BuildContext context, int index) {
            final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent, accentColor: Color(0xff7c7c7c), unselectedWidgetColor:Color(0xff7c7c7c),);
            return Theme(data: theme,
            child: ExpansionTileListItemWidget(prepareData[index].header, prepareData[index].body),);
          },
        ),
      ),
    );
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: '१. नोभल कोरोना भाइरस भनेको के हो?',
        body:
            "यो नयाँ प्रजातिको भाइरस हो जुन मानव जातिमा पहिले पहिचान भएको थिएन। यस भाइरसले मानिस र पशुहरूमा संक्रमण गर्दछ। यस भाइरसले सामान्य रुघाखोकी देखि गम्भीर प्रकारको तीव्र श्वासप्रश्वास Severe Acute Respiratory Syndrome (SARS) सम्म गराउन सक्दछ ।"),
    ItemModel(
        header: "२. के मानिसमा जनावरहरूबाट नोभल कोरोना भाइरस संक्रमित हुन सक्दछ?",
        body:
            "नोभल कोरोना भाइरस जनावरबाट मानिसमा संक्रमित भएको कुनै बैज्ञानिक आधार हाल छैन।"),
    ItemModel(
        header: "३. के नोभल कोरोना भाइरस र SARS एउटै हुन्?",
        body:
            "सन् २००३ मा देखिएको SARS र नोभल कोरोना भाइरस एउटै प्रजातिका भाइरस हुन्। दुवै भाइरसले बिरामीलाई गम्भीर बनाउन सक्दछन्। महत्त्वपूर्ण कुरा, नोभल कोरोना भाइरस मानिसहरू बीच सजिलै सर्न सक्दछ भनेर अझै पुष्टी भएको छैन।"),
    ItemModel(
        header: "४. मानिस कसरी यो भाइरसबाट संक्रमित हुन सक्छ ?",
        body:
            "मानिस कसरी यो भाइरसबाट संक्रमित भएका छन् भन्ने बारेमा आज सम्म वैज्ञानिक तवरले पुष्टी भएको छैन। हाल यस विषयमा अनुसन्धान भइरहेको छ ।"),
    ItemModel(
        header: "५. के यो एक व्यक्त्तिबाट अर्को व्यक्त्ति सर्न सक्दछ?",
        body:
            "अहिले निश्चितताका साथ भन्न सकिने अवस्था छैन। एउटै परिवारका सदस्यहरू बिरामी भएको पाइएकोले, मानव-मानव बीचमा सिमित तवरले सर्ने सम्भावना रहेको अनुमान गरिएको छ । साथै, परिवारका सदस्यहरू एकै स्रोतबाट संक्रमण भएको हुन सक्ने सम्भावना पनि रहेको छ ।"),
    ItemModel(
        header: "६. यस भाइरसको संक्रमणबाट कसरी बच्न सकिन्छ?",
        body:
            "सामान्यतः यस भाइरसको संक्रमण कसरी हुन्छ भन्ने बारेमा एकिन जानकारी छैन। तथापि रुघा, खोकी तथा श्वासप्रश्वासका बिरामीको नजिक नजाने तथा हातको सरसफाई नियमित गरेमा संक्रमणको सम्भावना कम रहन्छ ।"),
    ItemModel(
        header: "७. के कोरोना भाइरसको लागि उपचार छ?",
        body:
            "नोभल कोरोना भाइरसले गर्दा हुने रोगको लागि कुनै खास उपचार छैन। यद्यपि यो भाइरसले निम्त्याएका धेरै लक्षणहरूको उपचार गर्न सकिन्छ, त्यसैले बिरामीको उपचार लक्षणको आधारमा गरिन्छ । साथै यस भाइरसको विरुद्ध हाललाई कुनै खोप उपलब्ध छैन ।"),
  ];
}