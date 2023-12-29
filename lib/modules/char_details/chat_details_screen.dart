import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/models/message_model.dart';
import '../../Layout/social_app/cubit/states.dart';
import '../../models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  var messageController = TextEditingController();
ChatDetailsScreen({
  super.key,
     this.userModel,
});
  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {  },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel!.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel!.name!,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                // ignore: prefer_is_empty
              condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) =>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index) {
                            var message= SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel!.uId == message.senderId)
                              {
                                return buildMyMessage(message);
                              }
                                return buildMessage(message);
                          },
                          separatorBuilder: (context,index)=> const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(

                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type a message ...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ignore: sized_box_for_whitespace
                             Container(
                            height: 50.0,
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                                messageController.clear();

                              },
                              child: const Icon(Icons.send,
                                size: 16.0,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                fallback: (context)=>const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                ),
              ),
            );

          },

        );
      },

    );
  }
  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),

        ),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
          vertical: 5,
          horizontal: 10.0
      ),
      child:  Text(
        model.text!,
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:  BoxDecoration(
        color: Colors.teal.withOpacity(.3),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),

        ),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
          vertical: 5,
          horizontal: 10.0
      ),
      child:  Text(
        model.text!,
      ),
    ),
  );


}
