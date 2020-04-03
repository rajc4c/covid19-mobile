import 'package:intl/intl.dart';
import 'package:openspaces/common/utils.dart';

class HomeStat {
  int tested;
  int confirmed;
  int isolation;
  int recovered;
  int death;
  int icu;
  int occupiedIcu;
  int ventilator;
  int occupiedVentilator;
  int isolationBed;
  int occupiedIsolationBed;
  int facilityCount;
  String hotline;
  String updateDate;

  HomeStat({
    this.tested,
    this.confirmed,
    this.isolation,
    this.death,
    this.icu,
    this.occupiedIcu,
    this.ventilator,
    this.occupiedVentilator,
    this.isolationBed,
    this.occupiedIsolationBed,
    this.facilityCount,
    this.hotline,
    this.updateDate,
  });

  HomeStat.fromJson(Map<String, dynamic> json) {
    tested = json['tested'];
    confirmed = json['confirmed'];
    isolation = json['isolation'];
    recovered = json['total_recovered'];
    death = json['death'];
    icu = json['icu'];
    occupiedIcu = json['occupied_icu'];
    ventilator = json['ventilator'];
    occupiedVentilator = json['occupied_ventilator'];
    isolationBed = json['isolation_bed'];
    occupiedIsolationBed = json['occupied_isolation_bed'];
    facilityCount = json['facility_count'];
    hotline = json['hotline'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tested'] = this.tested;
    data['confirmed'] = this.confirmed;
    data['isolation'] = this.isolation;
    data['total_recovered'] = this.recovered;
    data['death'] = this.death;
    data['icu'] = this.icu;
    data['occupied_icu'] = this.occupiedIcu;
    data['ventilator'] = this.ventilator;
    data['occupied_ventilator'] = this.occupiedVentilator;
    data['isolation_bed'] = this.isolationBed;
    data['occupied_isolation_bed'] = this.occupiedIsolationBed;
    data['facility_count'] = this.facilityCount;
    data['hotline'] = this.hotline;
    data['update_date'] = this.updateDate;
    return data;
  }

  String getFormattedDate() {

    String nepaliDate = "";
    final outputFormat = new DateFormat(' d MMM y |').add_jm();
    final inputFormat = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime updatedDateTime = inputFormat.parse(updateDate);
    String text = outputFormat.format(updatedDateTime);

    List<String> dateList = [];
    dateList = text.split(" | ");
    String rawYyear = dateList[0].trim();
    String rawTime = dateList[1].trim();

    List<String> yearList = [];
    yearList = rawYyear.split(" ");

    String splitedDay = Utils.numberMap(yearList[0].trim());
    String splitedMonth = months[yearList[1].trim()];
    String splitedYear = Utils.numberMap(yearList[2].trim());


    List<String> timeList = [];
    timeList = rawTime.split(" ");

    String rawHrsMin = timeList[0].trim();
    String rawAmPm = amPmMap[timeList[1].trim()];

    List<String> hrsMinList = [];
    hrsMinList = rawHrsMin.split(":");

    String splittedHours = Utils.numberMap(hrsMinList[0].trim());
    String splittedMins = Utils.numberMap(hrsMinList[1].trim());


    nepaliDate = splitedDay+" "+splitedMonth+" "+splitedYear+" | "+splittedHours+":"+splittedMins+" "+rawAmPm;

    return nepaliDate.split("|")[0];
  }
}

final Map<String, String> months = {
  "Jan": "जनवरी",
  "Feb": "फेब्रुअरी",
  "Mar": "मार्च",
  "Apr": "अप्रिल",
  "May": "मे",
  "Jun": "जून",
  "Jul": "जुलाई",
  "Aug": "अगस्ट",
  "Sep": "सेप्टेम्बर",
  "Oct": "अक्टुबर",
  "Nov": "नोभेम्बर",
  "Dec": "डिसेम्बर",
};
final Map<String, String> amPmMap = {
  "AM": "बिहानी",
  "PM": "बेलुकी",
};
