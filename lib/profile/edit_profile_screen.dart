import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class EditProfileScreen extends StatelessWidget{
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
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
        title: Text('Edit Your Profile'),
        leadingWidth: 30,
        actions: [
          TextButton(
            onPressed: (){
              AppCubit.get(context).updateProfile(nameController.text, phoneController.text, bioController.text);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('UPDATE'),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AppCubit,AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          UserModel user = AppCubit.get(context).user;
          nameController.text = user.name;
          bioController.text = user.bio;
          phoneController.text = user.phone;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is UpdateLoadingState || state is AppProfileLoadingState || state is AppCoverLoadingState)
                  Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(height: 10,),
                    ],
                  ),
                Container(
                  height: 230,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                image: DecorationImage(
                                  image: AppCubit.get(context).coverImage == null ? NetworkImage(user.cover) : FileImage(AppCubit.get(context).coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: CircleAvatar(
                                radius: 20,
                                child: IconButton(icon: Icon(IconBroken.Camera),onPressed: () {
                                  AppCubit.get(context).pickCoverImage();
                                },),
                              ),
                            ),
                          ],
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 62,
                            child: CircleAvatar(
                              backgroundImage: AppCubit.get(context).profileImage == null ? NetworkImage(user.image) : FileImage(AppCubit.get(context).profileImage),
                              radius: 60,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: IconButton(icon: Icon(IconBroken.Camera),onPressed: () {
                              AppCubit.get(context).pickProfileImage();
                            },),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value){
                      if(value.isEmpty)
                          return 'can not be empty';
                      return null;
                    },
                    label: 'Enter Your Name',
                    prefix: IconBroken.Profile,
                ),
                SizedBox(height: 15,),
                defaultFormField(
                  controller: bioController,
                  type: TextInputType.text,
                  validate: (String value){
                    if(value.isEmpty)
                      return 'can not be empty';
                    return null;
                  },
                  label: 'Enter Your Bio',
                  prefix: IconBroken.Info_Circle,
                ),
                SizedBox(height: 15,),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value){
                    if(value.isEmpty)
                      return 'can not be empty';
                    return null;
                  },
                  label: 'Enter Your Phone',
                  prefix: IconBroken.Call,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}