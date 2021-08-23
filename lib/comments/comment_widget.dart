import 'package:flutter/material.dart';
import 'package:social_app/models/comment_model.dart';

Widget buildCommentItem(CommentModel comment,int index,context){
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment.userPhoto),
                radius: 20,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(comment.userName,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16,height: 1.4),),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: Colors.blue,size: 16,),
                      ],
                    ),
                    Text(comment.dateTime,style: Theme.of(context).textTheme.caption.copyWith(height: 1.4),),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(comment.comment,style: Theme.of(context).textTheme.bodyText1,),
          )
        ],
      ),
    );
}