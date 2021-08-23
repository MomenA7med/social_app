import 'package:flutter/material.dart';
import 'package:social_app/chat_details/chat_details_screen.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';

Widget buildChatItem(UserModel model,BuildContext context){
  return InkWell(
    onTap: (){
      navigateTo(context, ChatDatailsScreen(model));
    },
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 20,),
          Text(model.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}