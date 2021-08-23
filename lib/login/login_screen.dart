import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/register/register_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/view_model/login_cubit.dart';
import 'package:social_app/view_model/login_states.dart';

class LoginScreen extends StatelessWidget{
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginState>(
          listener: (context,state){
            if(state is LoginSuccessState ){
              navigateAndFinish(context,SocialLayout());
            }
          },
          builder: (context,state){
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue),),
                      SizedBox(height: 10,),
                      Text('Login now to browse our hot offers',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 30,),
                      defaultFormField(
                        label: 'Email Address',
                        type: TextInputType.emailAddress,
                        prefix: Icons.email_outlined,
                        controller: emailController,
                        validate: (String value) {
                          if (value.isEmpty)
                            return 'please Enter your email address';
                        },
                      ),
                      SizedBox(height: 20,),
                      defaultFormField(
                        label: 'password',
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock_outline,
                        isPassword: true,
                        controller: passController,
                        validate: (String value) {
                          if (value.isEmpty)
                            return 'password is too short';
                        },
                      ),
                      SizedBox(height: 15,),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: TextButton(onPressed: (){
                            if(formKey.currentState.validate()){
                              LoginCubit.get(context).login(emailController.text, passController.text);
                            }
                          },
                            child: Text('Login',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do not have an account ?',style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          TextButton(onPressed: () => navigateAndFinish(context,RegisterScreen()), child: Text('REGISTER',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }

}
