import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import 'package:socialapp2/components/deafult_components.dart';
import 'package:socialapp2/modules/new_post/new__post_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state) {
        if(state is SocialNewPostStates)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(
                      Icons.notifications,
                    color: Colors.grey,
                  ),),
              IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(
                      Icons.search,
                    color: Colors.grey,
                  ),),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.grey[350],
              backgroundColor:HexColor('333739'),
            color:  Colors.grey,
            height: 65.0,
              onTap:(index){
                cubit.changeBottomNav(index);
          },
            index: cubit.currentIndex,
            items: cubit.items,
          ),
        );
      },
    );
  }
}
