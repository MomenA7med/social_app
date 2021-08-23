import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel user = AppCubit.get(context).user;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 230,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(user.cover),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 62,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                          radius: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                Text(user.name,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25),),
                SizedBox(height: 5,),
                Text(user.bio,style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('100',style: Theme.of(context).textTheme.bodyText1,),
                        Text('Posts',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 17),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('265',style: Theme.of(context).textTheme.bodyText1,),
                        Text('Photos',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 17),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('700',style: Theme.of(context).textTheme.bodyText1,),
                        Text('Followers',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 17),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('900',style: Theme.of(context).textTheme.bodyText1,),
                        Text('Followings',style: Theme.of(context).textTheme.caption.copyWith(fontSize: 17),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: MaterialButton(onPressed: (){},child: Text('Add Photos'),color: Colors.blue,)),
                    SizedBox(width: 8,),
                    MaterialButton(onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },child: Icon(IconBroken.Edit),color: Colors.blue,)
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}