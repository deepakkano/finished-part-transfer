class dbModel {
  int? id;
  String? companyId;
  String? username;
  String? password;

  dbModel({this.id, this.companyId, this.username, this.password});

  factory dbModel.formMap(Map<String, dynamic> map) {
    return dbModel(
        id: map['id'],
        companyId: map['companyId'],
        username: map['username'],
        password: map['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyId': companyId,
      'username': username,
      'password': password
    };
  }
}
