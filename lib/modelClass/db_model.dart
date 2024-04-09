class dbModel {
  int? id;
  String? name;
  String? companyId;
  String? username;
  String? password;
  String? email;
  String? role;


  dbModel({this.id,this.name, this.companyId, this.username, this.password,this.email,this.role});

  factory dbModel.formMap(Map<String, dynamic> map) {
    return dbModel(
        id: map['id'],
        name:map['name'],
        companyId: map['companyId'],
        username: map['username'],
        password: map['password'],
        email:map['email'],
        role:map['role']);

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name':name,
      'companyId': companyId,
      'username': username,
      'password': password,
      'email':email,
      'role':role,
    };
  }
}
