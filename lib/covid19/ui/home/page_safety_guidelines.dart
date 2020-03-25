import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:openspaces/hospitalmap/widgets/covid_app_bar.dart';

class SafetyGuideLines {
  String imageSrc;
  String answers;

  SafetyGuideLines({this.imageSrc, this.answers});

  static List<SafetyGuideLines> get safetyGuideLinesList {
    List<SafetyGuideLines> safetyGuidelinesList = [];
    safetyGuidelinesList.add(SafetyGuideLines(
        imageSrc: "assets/images/safety_guideline_1.png",
        answers:
            "ज्वरो र खोकी लागेको व्यक्त्तिबाट टाढा रहने वा आफूलाई ज्वरो र खोकी लागेको छ भने पनि अरू व्यक्त्तिबाट टाढा रहने र मास्कको प्रयोग गर्ने ।"));
    safetyGuidelinesList.add(SafetyGuideLines(
        imageSrc: "assets/images/safety_guideline_2.png",
        answers:
            "बेलाबेलामा साबुन-पानीले कम्तिमा २० सेकेन्ड मिचिमिचि हात धुने वा अल्कोहल भएको स्यानिटाइजर प्रयोग गर्ने ।"));
    safetyGuidelinesList.add(SafetyGuideLines(
        imageSrc: "assets/images/safety_guideline_3.png",
        answers:
            "भिडभाडमा नजाने र अरुलाई पनि नजाने सुझाव दिने, हात मिलाउनुको सट्टा नमस्कार गर्ने ।"));
    safetyGuidelinesList.add(SafetyGuideLines(
        imageSrc: "assets/images/safety_guideline_4.png",
        answers:
            "खोक्दा वा हाछ्युँ गर्दा नाक मुख टिस्यू पेपर वा कुहिनाले छोप्ने र प्रयोग गरेको टिस्यू पेपरलाई बिर्को भएको फोहर फाल्ने भाँडोमा फाल्ने र साबुन-पानीले मिचिमिचि हात धुने वा अल्कोहल भएको स्यानिटाईजर प्रयोग गर्ने ।"));
    safetyGuidelinesList.add(SafetyGuideLines(
        imageSrc: "assets/images/safety_guideline_5.png",
        answers:
            "कोरोना प्रभावित देशबाट आएको व्यक्त्तिहरूमा माथिका लक्षणहरू देखिए स्वास्थ्य केन्द्रमा तुरून्त जानुपर्दछ । घरैमा बस्दा परिवारका सदस्यहरूबाट १४ दिन सम्म छुट्टै आईसोलेसनमा बस्नु पर्दछ ।"));
    return safetyGuidelinesList;
  }
}

class SafetyGuidelinesPage extends StatefulWidget {
  @override
  _SafetyGuidelinesPageState createState() => _SafetyGuidelinesPageState();
}

class _SafetyGuidelinesPageState extends State<SafetyGuidelinesPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: covidAppBar(),
        body: Stack(children: [
          Align(alignment: Alignment.topCenter, child: Padding(
            padding: EdgeInsets.all(16.0),
              child: Text("नोभल कोरोना भाइरसबाट कसरी आफू र अरुलाई बचाउने?", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),)),),

          Align(
            alignment: Alignment.center,
            child: CarouselSlider(
              enlargeCenterPage: true,
              items: List<Widget>.generate(
                  SafetyGuideLines.safetyGuideLinesList.length, (index) {
                SafetyGuideLines safetyGuidelines = SafetyGuideLines.safetyGuideLinesList[index];
                return Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),),
                    child: Column( children: <Widget>[
                      Image.asset(safetyGuidelines.imageSrc, height: 200.0, width: MediaQuery.of(context).size.width,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.green),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(safetyGuidelines.answers, style: TextStyle(color: Colors.white, fontSize: 16.0),)),
                        ),
                      )
                    ],),
                  ),
                );
              }),
              autoPlay: false,
              aspectRatio: 1,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    SafetyGuideLines.safetyGuideLinesList.length, (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                }),
              ))
        ]));
  }
}
