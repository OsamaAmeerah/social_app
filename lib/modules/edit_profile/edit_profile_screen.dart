import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/cubit/cubit.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import '../../components/deafult_components.dart';

class EditProfileScreen extends StatelessWidget {
var nameController = TextEditingController();
var bioController = TextEditingController();
var phoneController = TextEditingController();


  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(onPressed: (){

               SocialCubit.get(context).updateUser(
                   name: nameController.text,
                   phone: phoneController.text,
                   bio: bioController.text);
              },

                child: const Text('UPDATE',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),),
              const SizedBox(width: 15.0,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if(state is UserUpdateLoadingState)
                const LinearProgressIndicator(
                  color: Colors.teal,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 190.0,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: 
                            [
                              Container(
                              width: double.infinity,
                              height: 140.0,
                              decoration: BoxDecoration(
                                borderRadius:  const BorderRadius.only(
                                  topLeft: Radius.circular(4.0,),
                                  topRight: Radius.circular(4.0,),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null ? NetworkImage(
                                    '${userModel.cover}' ,
                                  ) : FileImage(coverImage) as ImageProvider,
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
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 15.0,
                                      ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 60.0,
                                backgroundImage: profileImage == null ? NetworkImage(
                                    '${userModel.image}') : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 17.0,
                                backgroundColor: Colors.teal,
                                child: IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                Row(
                  children: [
                    if(SocialCubit.get(context).profileImage != null)
                    Expanded(
                      child: Column(
                        children:
                        [
                          defaultButton(
                            background: Colors.teal,
                              todofunction: (){
                              SocialCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                              );
                              },
                              text: 'upload profile',
                          ),
                         /* const SizedBox(
                            height: 5.0,
                          ),
                          if(state is UserUpdateLoadingState)
                          const LinearProgressIndicator(),*/
                        ],
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(SocialCubit.get(context).coverImage != null)
                    Expanded(
                      child: Column(
                        children:
                        [
                          defaultButton(
                            background: Colors.teal,
                            todofunction: (){
                              SocialCubit.get(context).uploadCoverImage(
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                              );
                            },
                              text: 'upload cover',
                          ),
                        /*  if(state is UserUpdateLoadingState)
                            const SizedBox(height: 5.0,),
                          if(state is UserUpdateLoadingState)
                            const LinearProgressIndicator(),*/

                        ],
                      ),
                    ),
                  ],
                ),
                if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                  const SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  enabledBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                  focusedBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.person_outlined,
                ),
                const SizedBox(
                  height: 15.0,
                ),

                defaultFormField(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  enabledBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                  focusedBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                  controller: bioController,
                  type: TextInputType.name,
                  label: 'Bio',
                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'bio must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.article_outlined,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  enabledBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                  focusedBorderStyle: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: 'Phone',
                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.phone_outlined,
                ),

              ],
              ),
            ),
          ),
        );
      },

    );
  }
}
