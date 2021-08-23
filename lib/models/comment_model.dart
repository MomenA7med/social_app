
import 'package:flutter/material.dart';

class CommentModel {
  String uId;
  String userName;
  String userPhoto;
  String dateTime;
  String comment;

  CommentModel({
    @required this.uId,
    @required this.userName,
    @required this.userPhoto,
    @required this.dateTime,
    @required this.comment,
  });

  Map<String,String> toMap(){
    return {
      //'postId' : postId,
      'uId' : uId,
      'userName' : userName,
      'userPhoto' : userPhoto,
      'dateTime' : dateTime,
      'comment' : comment,
    };
  }

  factory CommentModel.fromMap(Map<String,dynamic> json){
    return CommentModel(
        uId: json['uId'],
        userName: json['userName'],
        userPhoto: json['userPhoto'],
        dateTime: json['dateTime'],
        comment: json['comment'],
    );
  }
}