import 'package:flutter/material.dart';

class PostModel{
  //String postId;
  String uId;
  String userName;
  String userPhoto;
  String dateTime;
  String postText;
  String postPhoto;

  PostModel({@required this.uId,@required this.userName,@required this.userPhoto,@required this.dateTime,@required this.postText,@required this.postPhoto});

  Map<String,String> toMap(){
    return {
      //'postId' : postId,
      'uId' : uId,
      'userName' : userName,
      'userPhoto' : userPhoto,
      'dateTime' : dateTime,
      'postText' : postText,
      'postPhoto' : postPhoto,
    };
  }

  factory PostModel.fromMap(Map<String,dynamic> json){
    return PostModel(
        uId: json['uId'],
        userName: json['userName'],
        userPhoto: json['userPhoto'],
        dateTime: json['dateTime'],
        postText: json['postText'],
        postPhoto: json['postPhoto']);
  }
}