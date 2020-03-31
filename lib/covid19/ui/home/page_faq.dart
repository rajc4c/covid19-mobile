import 'package:flutter/material.dart';
import 'package:openspaces/covid19/colors.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class Faq {
  String title;
  String answers;
  
  Faq({ this.title, this.answers });
  
  static List<Faq> get faqList {
    List<Faq> faqList = [];
    faqList.add(Faq(title: "नोभल कोरोना भाइरस भनेको के हो?", answers: "यो नयाँ प्रजातिको भाइरस हो जुन मानव जातिमा पहिले पहिचान भएको थिएन। यस भाइरसले मानिस र पशुहरूमा संक्रमण गर्दछ। यस भाइरसले सामान्य रुघाखोकी देखि गम्भीर प्रकारको तीव्र श्वासप्रश्वास Severe Acute Respiratory Syndrome (SARS) सम्म गराउन सक्दछ ।"));
    faqList.add(Faq(title: "के मानिसमा जनावरहरूबाट नोभल कोरोना भाइरस संक्रमित हुन सक्दछ?", answers: "नोभल कोरोना भाइरस जनावरबाट मानिसमा संक्रमित भएको कुनै बैज्ञानिक आधार हाल छैन।"));
    faqList.add(Faq(title: "के नोभल कोरोना भाइरस र SARS एउटै हुन्?", answers: "सन् २००३ मा देखिएको SARS र नोभल कोरोना भाइरस एउटै प्रजातिका भाइरस हुन्। दुवै भाइरसले बिरामीलाई गम्भीर बनाउन सक्दछन्। महत्त्वपूर्ण कुरा, नोभल कोरोना भाइरस मानिसहरू बीच सजिलै सर्न सक्दछ भनेर अझै पुष्टी भएको छैन।"));
    faqList.add(Faq(title: "मानिस कसरी यो भाइरसबाट संक्रमित हुन सक्छ ?", answers: "मानिस कसरी यो भाइरसबाट संक्रमित भएका छन् भन्ने बारेमा आज सम्म वैज्ञानिक तवरले पुष्टी भएको छैन। हाल यस विषयमा अनुसन्धान भइरहेको छ ।"));
    faqList.add(Faq(title: "के यो एक व्यक्त्तिबाट अर्को व्यक्त्ति सर्न सक्दछ?", answers: "अहिले निश्चितताका साथ भन्न सकिने अवस्था छैन। एउटै परिवारका सदस्यहरू बिरामी भएको पाइएकोले, मानव-मानव बीचमा सिमित तवरले सर्ने सम्भावना रहेको अनुमान गरिएको छ । साथै, परिवारका सदस्यहरू एकै स्रोतबाट संक्रमण भएको हुन सक्ने सम्भावना पनि रहेको छ ।"));
    faqList.add(Faq(title: "यस भाइरसको संक्रमणबाट कसरी बच्न सकिन्छ?", answers: "सामान्यतः यस भाइरसको संक्रमण कसरी हुन्छ भन्ने बारेमा एकिन जानकारी छैन। तथापि रुघा, खोकी तथा श्वासप्रश्वासका बिरामीको नजिक नजाने तथा हातको सरसफाई नियमित गरेमा संक्रमणको सम्भावना कम रहन्छ ।"));
    faqList.add(Faq(title: "के कोरोना भाइरसको लागि उपचार छ?", answers: "नोभल कोरोना भाइरसले गर्दा हुने रोगको लागि कुनै खास उपचार छैन। यद्यपि यो भाइरसले निम्त्याएका धेरै लक्षणहरूको उपचार गर्न सकिन्छ, त्यसैले बिरामीको उपचार लक्षणको आधारमा गरिन्छ । साथै यस भाइरसको विरुद्ध हाललाई कुनै खोप उपलब्ध छैन ।"));
    return faqList;
  }
}
class FaqPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OpenSpaceColors.defaultBackground,
      appBar: covidAppBarText(title: "प्राय सोधिने प्रश्नहरू",),
      body: Padding(
//        padding: const EdgeInsets.only(left:16.0, right: 16.0),
        padding: const EdgeInsets.only(left:8.0, right: 8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Faq.faqList.length,
            itemBuilder: (context, pos) {
            Faq faq = Faq.faqList[pos];

            return  ExpansionTile(

              title: Text("${pos+1}. ${faq.title}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14.0),),

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(faq.answers, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12.0, height: 1.5, letterSpacing: 1.5),),
                  ),
                  SizedBox(height: 10,)
                ],
              );



        }),
      ),
    );
  }
}
