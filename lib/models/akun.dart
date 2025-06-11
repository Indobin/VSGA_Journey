class Akun {
  int? id;
  String? name;
  String? username;
  String? noHp;
  String? password;

  Akun({
    this.id,
    this.name,
    this.username,
    this.noHp,
    this.password,
  });

 Map<String, dynamic> toMap() {
  var map = <String, dynamic>{};
  if (id != null) {
    map['id'] = id;
  }
  map['name'] = name;
  map['username'] = username;
  map['noHp'] = noHp;
  map['password'] = password;
  return map;
  }

  Akun.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    username = map['username'];
    noHp = map['noHp'];
    password = map['password'];
  }

}
