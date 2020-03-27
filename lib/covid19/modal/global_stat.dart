class GlobalStat {
  int _totalConfirmed;
  int _totalDeaths;
  int _totalRecovered;
  int _totalNewCases;
  int _totalNewDeaths;
  int _totalActiveCases;
  int _totalCasesPerMillionPop;
  String _created;

  GlobalStat(
      {int totalConfirmed,
        int totalDeaths,
        int totalRecovered,
        int totalNewCases,
        int totalNewDeaths,
        int totalActiveCases,
        int totalCasesPerMillionPop,
        String created}) {
    this._totalConfirmed = totalConfirmed;
    this._totalDeaths = totalDeaths;
    this._totalRecovered = totalRecovered;
    this._totalNewCases = totalNewCases;
    this._totalNewDeaths = totalNewDeaths;
    this._totalActiveCases = totalActiveCases;
    this._totalCasesPerMillionPop = totalCasesPerMillionPop;
    this._created = created;
  }

  int get totalConfirmed => _totalConfirmed;
  set totalConfirmed(int totalConfirmed) => _totalConfirmed = totalConfirmed;
  int get totalDeaths => _totalDeaths;
  set totalDeaths(int totalDeaths) => _totalDeaths = totalDeaths;
  int get totalRecovered => _totalRecovered;
  set totalRecovered(int totalRecovered) => _totalRecovered = totalRecovered;
  int get totalNewCases => _totalNewCases;
  set totalNewCases(int totalNewCases) => _totalNewCases = totalNewCases;
  int get totalNewDeaths => _totalNewDeaths;
  set totalNewDeaths(int totalNewDeaths) => _totalNewDeaths = totalNewDeaths;
  int get totalActiveCases => _totalActiveCases;
  set totalActiveCases(int totalActiveCases) =>
      _totalActiveCases = totalActiveCases;
  int get totalCasesPerMillionPop => _totalCasesPerMillionPop;
  set totalCasesPerMillionPop(int totalCasesPerMillionPop) =>
      _totalCasesPerMillionPop = totalCasesPerMillionPop;
  String get created => _created;
  set created(String created) => _created = created;

  GlobalStat.fromJson(Map<String, dynamic> json) {
    _totalConfirmed = json['totalConfirmed'];
    _totalDeaths = json['totalDeaths'];
    _totalRecovered = json['totalRecovered'];
    _totalNewCases = json['totalNewCases'];
    _totalNewDeaths = json['totalNewDeaths'];
    _totalActiveCases = json['totalActiveCases'];
    _totalCasesPerMillionPop = json['totalCasesPerMillionPop'];
    _created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalConfirmed'] = this._totalConfirmed;
    data['totalDeaths'] = this._totalDeaths;
    data['totalRecovered'] = this._totalRecovered;
    data['totalNewCases'] = this._totalNewCases;
    data['totalNewDeaths'] = this._totalNewDeaths;
    data['totalActiveCases'] = this._totalActiveCases;
    data['totalCasesPerMillionPop'] = this._totalCasesPerMillionPop;
    data['created'] = this._created;
    return data;
  }
}