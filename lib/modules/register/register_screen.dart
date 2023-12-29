import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/social_layout.dart';
import '../../components/deafult_components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(context) {
    return  BlocProvider(
      create: (context) => SocialRegisterCubit() ,
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(
                context,
                SocialLayout(),
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
          appBar: AppBar(),
          body:  Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Register now to join our community',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height:30.0,
                      ),
                      defaultFormField(controller: nameController,
                        style: const TextStyle(
                          color: Colors.white,

                          decorationColor: Colors.white,
                        ),
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
                        type: TextInputType.name,
                        label: 'User Name',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultFormField(controller: emailController,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIconColor: Colors.grey,
                        suffixIconColor: Colors.grey,
                        enabledBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                        focusedBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(20.0)),),

                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIconColor: Colors.grey,
                        suffixIconColor: Colors.grey,
                        enabledBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                        focusedBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(20.0)),),

                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'password is too short';
                          }
                          return null;

                        },
                        prefix: Icons.lock,
                        suffix: SocialRegisterCubit.get(context).suffix,
                        onSubmit: (value){

                        },
                        isPassword: SocialRegisterCubit.get(context).isPassword,
                        suffixPressed: (){
                          SocialRegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultFormField(controller: phoneController,
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
                        type: TextInputType.phone,
                        label: 'Phone Number',
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your phone number';
                          }
                          return null;
                        },
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height:20.0,
                      ),
                      ConditionalBuilder(
                        condition:state is! SocialRegisterLoadingState ,
                        builder: (context) =>  defaultButton(
                          background: Colors.teal,
                          todofunction: (){
                            if(formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).userRegister(
                                name : nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',isUpperCase: true,
                        ),
                        fallback:(context)=> const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
          },
      ),
    );
  }
}