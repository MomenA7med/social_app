import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class AddPostScreen extends StatelessWidget{
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(icon: Icon(IconBroken.Arrow___Left_Circle,color: Colors.black,), onPressed: () {
            Navigator.of(context).pop();
          },),
        ),
        title: Text('Add New Post'),
        leadingWidth: 30,
        actions: [
          TextButton(
            onPressed: (){
              if(AppCubit.get(context).imagePost != null){
                AppCubit.get(context).createNewPostWithImage(dateTime: DateTime.now().toString(), postText: textController.text);
              }else{
                AppCubit.get(context).createNewPost(dateTime: DateTime.now().toString(), postText: textController.text);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('Post'),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(AppCubit.get(context).user.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(AppCubit.get(context).user.name,style: Theme.of(context).textTheme.bodyText1,),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind ...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if(AppCubit.get(context).imagePost != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(AppCubit.get(context).imagePost),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(icon: Icon(Icons.close),onPressed: () {
                        AppCubit.get(context).closePostImage();
                      },),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        AppCubit.get(context).getPostImage();
                      },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(IconBroken.Image),
                           SizedBox(width: 5,),
                           Text('add photo'),
                         ],
                       ),),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                        child: Text('# tags'),
                      ),
                    ),
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