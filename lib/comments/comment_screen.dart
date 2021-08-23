import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/comments/comment_widget.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class CommentScreen extends StatelessWidget{
  final String postId;
  final commentController = TextEditingController();
  CommentScreen({@required this.postId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition: AppCubit.get(context).comments.length > 0,
                      builder: (context) => ListView.separated(
                        //shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildCommentItem(AppCubit.get(context).comments[index],index,context),
                        separatorBuilder: (context, index) => SizedBox(height: 5,),
                        itemCount: AppCubit.get(context).comments.length,
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator(),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: defaultFormField(controller: commentController, type: TextInputType.text, validate: (String value){
                          if(value.isEmpty)
                            return 'can not be empty';
                          return null;
                        }, label: 'write your comment', prefix: Icons.comment),
                      ),
                      IconButton(onPressed: (){
                        AppCubit.get(context).commentPost(postId, commentController.text);
                        }, icon: Icon(IconBroken.Arrow___Right_Square),iconSize: 30,color: Colors.black,),
                    ],
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}