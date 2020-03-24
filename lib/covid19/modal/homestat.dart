class HomeStat {
  int _tested;
  int _confirmed;
  int _isolation;
  int _death;
  int _icu;
  int _occupiedIcu;
  int _ventilator;
  int _occupiedVentilator;
  int _isolationBed;
  int _occupiedIsolationBed;
  List<String> _phones;
  String _time;

  HomeStat(
      {int tested,
        int confirmed,
        int isolation,
        int death,
        int icu,
        int occupiedIcu,
        int ventilator,
        int occupiedVentilator,
        int isolationBed,
        int occupiedIsolationBed,
        List<String> phones,
        String time}) {
    this._tested = tested;
    this._confirmed = confirmed;
    this._isolation = isolation;
    this._death = death;
    this._icu = icu;
    this._occupiedIcu = occupiedIcu;
    this._ventilator = ventilator;
    this._occupiedVentilator = occupiedVentilator;
    this._isolationBed = isolationBed;
    this._occupiedIsolationBed = occupiedIsolationBed;
    this._phones = phones;
    this._time = time;
  }

  int get tested => _tested;
  set tested(int tested) => _tested = tested;
  int get confirmed => _confirmed;
  set confirmed(int confirmed) => _confirmed = confirmed;
  int get isolation => _isolation;
  set isolation(int isolation) => _isolation = isolation;
  int get death => _death;
  set death(int death) => _death = death;
  int get icu => _icu;
  set icu(int icu) => _icu = icu;
  int get occupiedIcu => _occupiedIcu;
  set occupiedIcu(int occupiedIcu) => _occupiedIcu = occupiedIcu;
  int get ventilator => _ventilator;
  set ventilator(int ventilator) => _ventilator = ventilator;
  int get occupiedVentilator => _occupiedVentilator;
  set occupiedVentilator(int occupiedVentilator) =>
      _occupiedVentilator = occupiedVentilator;
  int get isolationBed => _isolationBed;
  set isolationBed(int isolationBed) => _isolationBed = isolationBed;
  int get occupiedIsolationBed => _occupiedIsolationBed;
  set occupiedIsolationBed(int occupiedIsolationBed) =>
      _occupiedIsolationBed = occupiedIsolationBed;
  List<String> get phones => _phones;
  set phones(List<String> phones) => _phones = phones;
  String get time => _time;
  set time(String time) => _time = time;

  HomeStat.fromJson(Map<String, dynamic> json) {
    _tested = json['tested'];
    _confirmed = json['confirmed'];
    _isolation = json['isolation'];
    _death = json['death'];
    _icu = json['icu'];
    _occupiedIcu = json['occupied_icu'];
    _ventilator = json['ventilator'];
    _occupiedVentilator = json['occupied_ventilator'];
    _isolationBed = json['isolation_bed'];
    _occupiedIsolationBed = json['occupied_isolation_bed'];
    _phones = json['phones'].cast<String>();
    _time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tested'] = this._tested;
    data['confirmed'] = this._confirmed;
    data['isolation'] = this._isolation;
    data['death'] = this._death;
    data['icu'] = this._icu;
    data['occupied_icu'] = this._occupiedIcu;
    data['ventilator'] = this._ventilator;
    data['occupied_ventilator'] = this._occupiedVentilator;
    data['isolation_bed'] = this._isolationBed;
    data['occupied_isolation_bed'] = this._occupiedIsolationBed;
    data['phones'] = this._phones;
    data['time'] = this._time;
    return data;
  }
}