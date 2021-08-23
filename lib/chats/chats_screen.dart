import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chats/chats_widget.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class ChatsScreen extends StatelessWidget{

  //List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
        listener:  (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: AppCubit.get(context).users.length > 0,
             builder: (context) => ListView.separated(
            itemBuilder: (context,index) {
              return buildChatItem(AppCubit.get(context).users[index],context);
            },
            separatorBuilder: (context,index) => Container(height: 1,color: Colors.grey,),
            itemCount: AppCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}