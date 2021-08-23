import 'package:flutter/material.dart';
import 'package:social_app/models/message_model.dart';

Widget buildMessage(MessageModel messageModel) => Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  ),
                  child: Text(messageModel.text,style: TextStyle(fontSize: 16))),
              );

Widget buildMyMessage(MessageModel messageModel) => Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  ),
                  child: Text(messageModel.text,style: TextStyle(fontSize: 16),)),
              );