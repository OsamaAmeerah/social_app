import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/models/post_model.dart';
import 'package:socialapp2/styles/colors.dart';
import '../../Layout/social_app/cubit/states.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context,  state) {  },
      builder: (BuildContext context,  state) { 
        return ConditionalBuilder(
          // ignore: prefer_is_empty, unnecessary_null_comparison
          condition: state is! SocialGetPostsErrorStates && SocialCubit.get(context).userModel != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 8.0,
                    shadowColor: Colors.white10,
                    margin: const EdgeInsets.all(8.0,),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/portrait-young-people-with-thought-bubble_23-2149184861.jpg?w=740&t=st=1703008200~exp=1703008800~hmac=8e542387dc1523e80a508ddc728b8feb26b81f98e56776a9e1307bf5b56fc874'
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,

                          height: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context, index),
                    itemCount: SocialCubit.get(context).posts.length,
                    separatorBuilder: (context,index)=>const SizedBox(
                      height: 10.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  )
                ],
              ),

            );
          },
          fallback: (context)=>const Center(child: CircularProgressIndicator(
            color: Colors.teal,
          )),

        );
      },
    );

  }

  Widget buildPostItem(PostModel model, context, index)=>Card(
    color: HexColor('333739'),
    margin: const EdgeInsets.symmetric(horizontal: 8.0,),
    elevation: 8.0,
    shadowColor: Colors.white10,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child:  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,

        children:
        [
          Row(
            children: [
               CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}',
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                       Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),

                          ),
                          const SizedBox(width: 5.0,),
                          const Icon(
                            Icons.check_circle,
                            size: 16.0,
                            color: defaultColor,

                          ),

                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                          height: 1.4,
                        ),

                      ),
                    ],
                  )),
              const SizedBox(width: 15,),
              IconButton(
                onPressed: (){

                }, icon: const Icon(
                Icons.more_horiz,
                size: 16.0,
                color: Colors.white,
              ),
              ),


            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          if(model.postImage != '')
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 140.0,
              decoration:   BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image:  DecorationImage(image: NetworkImage(
                  '${model.postImage}',
                ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.chat,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '3 comment',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom:10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                       CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                        ),

                      ),


                    ],
                  ),
                  onTap: (){

                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: (){
                     SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),

            ],
          ),



        ],
      ),
    ),
  );



}
