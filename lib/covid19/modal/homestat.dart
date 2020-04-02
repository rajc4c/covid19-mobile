import 'package:intl/intl.dart';

class HomeStat {
  int tested;
  int confirmed;
  int isolation;
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

    final outputFormat = new DateFormat(' d MMM y |').add_jm();
    final inputFormat = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime updatedDateTime = inputFormat.parse(updateDate);
    String text = outputFormat.format(updatedDateTime);

    List<String> dateList = [];
    dateList = text.split(" | ");
    String yearRaw = dateList[0].trim();
    String time = dateList[1].trim();
    

    print("Date : "+text);

    return text;
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
