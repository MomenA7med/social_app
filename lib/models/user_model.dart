class UserModel {
  String name;
  String phone;
  String uId;
  String email;
  String image;
  String cover;
  String bio;


  UserModel(this.name,this.phone,this.uId,this.email,this.image,this.cover,this.bio);

  Map<String,String> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
    };
  }

  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(json['name'], json['phone'], json['uId'], json['email'], json['image'], json['cover'], json['bio']);
  }
}