class LoginResponse {
  String _token;
  int _userId;
  String _email;
  List<Roles> _roles;

  LoginResponse({String token, int userId, String email, List<Roles> roles}) {
    this._token = token;
    this._userId = userId;
    this._email = email;
    this._roles = roles;
  }

  String get token => _token;
  set token(String token) => _token = token;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get email => _email;
  set email(String email) => _email = email;
  List<Roles> get roles => _roles;
  set roles(List<Roles> roles) => _roles = roles;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _userId = json['user_id'];
    _email = json['email'];
    if (json['roles'] != null) {
      _roles = new List<Roles>();
      json['roles'].forEach((v) {
        _roles.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    data['user_id'] = this._userId;
    data['email'] = this._email;
    if (this._roles != null) {
      data['roles'] = this._roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int _group;
  Null _province;
  int _facility;
  String _groupName;
  String _provinceName;
  String _facilityName;

  Roles(
      {int group,
        Null province,
        int facility,
        String groupName,
        String provinceName,
        String facilityName}) {
    this._group = group;
    this._province = province;
    this._facility = facility;
    this._groupName = groupName;
    this._provinceName = provinceName;
    this._facilityName = facilityName;
  }

  int get group => _group;
  set group(int group) => _group = group;
  Null get province => _province;
  set province(Null province) => _province = province;
  int get facility => _facility;
  set facility(int facility) => _facility = facility;
  String get groupName => _groupName;
  set groupName(String groupName) => _groupName = groupName;
  String get provinceName => _provinceName;
  set provinceName(String provinceName) => _provinceName = provinceName;
  String get facilityName => _facilityName;
  set facilityName(String facilityName) => _facilityName = facilityName;

  Roles.fromJson(Map<String, dynamic> json) {
    _group = json['group'];
    _province = json['province'];
    _facility = json['facility'];
    _groupName = json['group_name'];
    _provinceName = json['province_name'];
    _facilityName = json['facility_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this._group;
    data['province'] = this._province;
    data['facility'] = this._facility;
    data['group_name'] = this._groupName;
    data['province_name'] = this._provinceName;
    data['facility_name'] = this._facilityName;
    return data;
  }
}
