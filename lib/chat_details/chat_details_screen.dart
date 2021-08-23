import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chat_details/chat_details_widget.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class ChatDatailsScreen extends StatelessWidget{

  final UserModel userModel;
  final messageController = TextEditingController();

  ChatDatailsScreen(this.userModel);
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getMessages(recieverId: userModel.uId);
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<AppCubit,AppState>(
          listener: (context,state){} ,
          builder: (context,state) {

            return Scaffold(
            appBar: AppBar(
              title: Text(userModel.name),
              titleSpacing: 0,
            ),
            body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ConditionalBuilder(
                          condition: AppCubit.get(context).messages.length > 0,
                          builder: (context) => ListView.separated(
                            itemBuilder: (context,index) {
                              if(AppCubit.get(context).user.uId == AppCubit.get(context).messages[index].senderId)
                                return buildMyMessage(AppCubit.get(context).messages[index]);
                              return buildMessage(AppCubit.get(context).messages[index]);  
                            },
                            separatorBuilder: (context,index) => SizedBox(height: 10,),
                            itemCount: AppCubit.get(context).messages.length,
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator(),),
                        ),
                      ),
                        Row(
                          children: [
                            Expanded(
                              child: defaultFormField(controller: messageController, type: TextInputType.text, validate: (String value){
                                if(value.isEmpty)
                                  return 'can not be empty';
                                return null;
                              }, label: 'write your message', prefix: Icons.comment),
                            ),
                            IconButton(onPressed: (){
                                AppCubit.get(context).sendMessage(recieverId: userModel.uId, message: messageController.text, dateTime: DateTime.now().toString());
                             },
                            icon: Icon(IconBroken.Arrow___Right_Square),iconSize: 30,color: Colors.black,),
                      ],
                    ),
                  ],
                ),
              ),
              );
          }
          );
      },
    );
  }
}