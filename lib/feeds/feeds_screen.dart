import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/feeds/add_post_screen.dart';
import 'package:social_app/feeds/feeds_widgets.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: BlocConsumer<AppCubit,AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(state is GetPostsLoadingState && AppCubit.get(context).isLikedList.length == 0){
                return Center(child: CircularProgressIndicator(),);
              }
              return ConditionalBuilder(
                condition: AppCubit.get(context).posts.length > 0 && AppCubit.get(context).isLikedList.length > 0,
                builder: (context) {
                  print('size ${AppCubit.get(context).isLikedList.length.toString()}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCommunicateItem(context),
                      SizedBox(
                        height: 15,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: AppCubit.get(context).posts.length,
                        separatorBuilder: (context, index) => SizedBox(height: 15,),
                        itemBuilder: (context, index) => buildPostItem(context,AppCubit.get(context).posts[index],index),
                      ),
                    ],
                  );
                },
                fallback: (context) {
                  return Center(
                    child: Text('No posts yet',style: Theme.of(context).textTheme.bodyText1,),
                  );
                },
              );
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(IconBroken.Upload),
        onPressed: (){
          navigateTo(context,AddPostScreen());
        },
      ),
    );
  }
}
