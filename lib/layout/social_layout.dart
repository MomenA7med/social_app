import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chats/chats_screen.dart';
import 'package:social_app/feeds/feeds_screen.dart';
import 'package:social_app/notification/notification_screen.dart';
import 'package:social_app/profile/profile_screen.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/users/users_screen.dart';
import 'package:social_app/view_model/app_cubit.dart';
import 'package:social_app/view_model/app_state.dart';

class SocialLayout extends StatefulWidget{
  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}
class _SocialLayoutState extends State<SocialLayout> {
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<String> titles =[
    'Home',
    'Chats',
    'Users',
    'Profile',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[_currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Profile),label: 'Profile'),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}