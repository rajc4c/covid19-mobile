class GlobalStat {
  int totalConfirmed;
  int totalDeaths;
  int totalRecovered;
  String created;

  GlobalStat(
      {int totalConfirmed,
      int totalDeaths,
      int totalRecovered,
      int totalNewCases,
      int totalNewDeaths,
      int totalActiveCases,
      int totalCasesPerMillionPop,
      String created}) {
    this.totalConfirmed = totalConfirmed;
    this.totalDeaths = totalDeaths;
    this.totalRecovered = totalRecovered;
    this.created = created;
  }

  GlobalStat.fromJson(Map<String, dynamic> json) {
    totalConfirmed = json['total_infected_global'];
    totalDeaths = json['total_deaths_global'];
    totalRecovered = json['total_recovered_global'];
    created = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalConfirmed'] = this.totalConfirmed;
    data['totalDeaths'] = this.totalDeaths;
    data['totalRecovered'] = this.totalRecovered;
    data['created'] = this.created;
    return data;
  }
}
