
class User{
  int? id;
  int? user_id;
  String name;
  String email;
  String user_type;
  int? role_id;
  String? created_at;
  String? updated_at;
  String? password;
  String? mobile;
  String? password_confirmation;

  User({this.id,required this.name,required this.email,required this.user_type,this.role_id,
  this.created_at,this.updated_at,this.password,this.user_id,this.mobile});


  Map<String,dynamic> toJson()=>{
    'user_id':user_id,
    'name':name,
    'email':email,
    'user_type':user_type,
    'mobile':mobile
  };

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
      user_id: parsedJson['id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      user_type: parsedJson['user_type'],
      role_id: parsedJson['role_id'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at']
    );
  }

  factory User.fromDB(Map<String,dynamic> parsedJson){
    return User(
      id: parsedJson['id'],
      user_id: parsedJson['user_id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      mobile: parsedJson['mobile'],
      user_type: parsedJson['user_type'],
      //role_id: parsedJson['role_id'],
    //  created_at: parsedJson['created_at'],
     // updated_at: parsedJson['updated_at']
    );
  }
}