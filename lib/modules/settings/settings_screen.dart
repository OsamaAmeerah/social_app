import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import 'package:socialapp2/components/deafult_components.dart';
import 'package:socialapp2/modules/edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
      builder: (context,state){
       var userModel = SocialCubit.get(context).userModel;
       return SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
               // ignore: sized_box_for_whitespace
               Container(
                 height: 190.0,
                 child: Stack(
                     alignment: AlignmentDirectional.bottomCenter,
                     children: [
                       Align(
                         alignment: Alignment.topCenter,
                         child: Container(
                           width: double.infinity,
                           height: 140.0,
                           decoration: BoxDecoration(
                             borderRadius:  const BorderRadius.only(
                               topLeft: Radius.circular(4.0,),
                               topRight: Radius.circular(4.0,),
                             ),
                             image: DecorationImage(
                               image: NetworkImage(
                                 userModel!.cover!,
                             ),
                               fit: BoxFit.cover,
                             ),
                           ),
                         ),
                       ),
                       CircleAvatar(
                         radius: 65.0,
                         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                         child: CircleAvatar(
                           backgroundColor: Colors.grey,
                           radius: 60.0,
                           backgroundImage: NetworkImage(userModel.image!),
                         ),
                       ),
                     ]
                 ),
               ),
               const SizedBox(
                 height: 5.0,
               ),
               Text(
                 userModel.name!,
                 style: Theme.of(context).textTheme.bodyLarge,
               ),
               Text(
                 userModel.bio!,
                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
                   color: Colors.grey,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(
                   vertical: 20.0,
                 ),
                 child: Row(
                   children: [
                     Expanded(
                       child: InkWell(
                         child: Column(
                           children: [
                             Text(
                               '100',
                               style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                 color: Colors.white,
                               ),
                             ),
                             Text(
                               'posts',
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
                     Expanded(
                       child: InkWell(
                         child: Column(
                           children: [
                             Text(
                               '255',
                               style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                 color: Colors.white,
                               ),
                             ),
                             Text(
                               'photos',
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
                     Expanded(
                       child: InkWell(
                         child: Column(
                           children: [
                             Text(
                               '10k',
                               style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                 color: Colors.white,
                               ),
                             ),
                             Text(
                               'Followers',
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
                     Expanded(
                       child: InkWell(
                         child: Column(
                           children: [
                             Text(
                               '66',
                               style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                 color: Colors.white,
                               ),
                             ),
                             Text(
                               'Following',
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
                   ],
                 ),
               ),
               Row(
                 children: [
                   Expanded(
                     child: OutlinedButton(
                       style: const ButtonStyle(
                         overlayColor: MaterialStatePropertyAll(Colors.grey),
                       ),
                       onPressed: () {

                     },
                       child: const Text(
                         'Add Photos',
                         style: TextStyle(
                           color: Colors.teal,
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(width: 10.0,),
                   OutlinedButton(
                     style: const ButtonStyle(
                       overlayColor: MaterialStatePropertyAll(Colors.grey),
                     ),
                       onPressed: (){
                       navigateTo(context, EditProfileScreen());
                       },
                       child: const Icon(Icons.edit,
                         color: Colors.teal,
                       ),
                   ),
                 ],
               ),
               Row(
                 children: [
                   OutlinedButton(
                     style: const ButtonStyle(
                       overlayColor: MaterialStatePropertyAll(Colors.grey),
                     ),
                     onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                   },
                     child: const Text(
                       'Subscribe',
                       style: TextStyle(
                         color: Colors.teal,
                       ),
                     ),
                   ),
                   const SizedBox(width: 10.0,),
                   OutlinedButton(
                     style: const ButtonStyle(
                       overlayColor: MaterialStatePropertyAll(Colors.grey),
                     ),
                       onPressed: (){
                         FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                       },
                       child: const Text(
                         'UnSubscribe',
                         style: TextStyle(
                           color: Colors.teal,
                         ),
                       ),
                   ),
                 ],
               ),

             ],
           ),
         ),
       );
      },
    );

  }
}
