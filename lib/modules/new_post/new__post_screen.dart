import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import '../../components/deafult_components.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({super.key});
var textController = TextEditingController();
var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: (){
                  if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );

                          }
                },
                child: const Text(
                  'POST',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),)
            ],
          ),
          body:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(
                  color: Colors.teal,
                ),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(
                  height: 10.0,
                ),
                 Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25.0,
                      backgroundImage: NetworkImage(SocialCubit.get(context).userModel!.image!),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Text(
                        SocialCubit.get(context).userModel!.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),

                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      focusColor: Colors.teal,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,

                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:
                  [
                    Container(
                      width: double.infinity,
                      height: 140.0,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 17.0,
                        backgroundColor: Colors.teal,
                        child: IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      OutlinedButton(
                        style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.grey),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: const Row(
                          children: [
                            Icon(
                                Icons.image,
                            color: Colors.teal,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photos',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.grey),
                        ),
                        onPressed: () {

                        },
                        child: const Text(
                          '# tags',
                          style: TextStyle(
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
        );
      },

    );
  }
}
