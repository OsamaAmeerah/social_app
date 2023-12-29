import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import 'package:socialapp2/components/deafult_components.dart';
import 'package:socialapp2/models/user_model.dart';
import 'package:socialapp2/modules/char_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,  state) {  },
      builder: (context,  state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) =>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index] , context),
            separatorBuilder: (context ,index) =>Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: myDivider(),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(
            color: Colors.teal,
          )),
        );
      },

    );

  }


  Widget buildChatItem(UserModel model, context)=>InkWell(
    child:  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(width: 15,),
          Row(
            children: [
              Text(
                '${model.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),

              ),
            ],
          ),

        ],
      ),
    ),
    onTap: (){
     navigateTo(context, ChatDetailsScreen(
       userModel: model,
     ));
    },
  );
}
