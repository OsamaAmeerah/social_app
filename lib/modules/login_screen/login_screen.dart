import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp2/Layout/social_app/social_layout.dart';
import 'package:socialapp2/components/deafult_components.dart';
import 'package:socialapp2/modules/register/register_screen.dart';
import 'package:socialapp2/shared/network/local/cahce_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, LoginStates state) {
          if(state is LoginErrorState)
            {
              showToast(text: state.error, state: ToastStates.ERROR);
            }
          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId).then((value) {
                    navigateAndFinish(context, SocialLayout());
              });
            }
        },
        builder: (BuildContext context, LoginStates state)
          {
            return  Scaffold(
              appBar: AppBar(),
          body:   Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                       const Center(child: Icon(Icons.person_pin_outlined, color: Colors.teal, size: 120,)),
                      const SizedBox(height: 10.0),
                           const Center(
                             child: Text(
                                'Login now to join our community',
                              style: TextStyle(
                                color: Colors.grey,
                              ),

                          ),
                           ),
                      const SizedBox(height: 20.0),
                      defaultFormField(

                        controller: emailController,
                        type: TextInputType.emailAddress,
                        enabledBorderStyle: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorderStyle: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        label: 'email address',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIconColor: Colors.grey,
                        prefix: Icons.email,
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        onSubmit: (value){
                          if(formKey.currentState!.validate())
                          {

                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIconColor: Colors.grey,
                         suffixIconColor: Colors.grey,
                        enabledBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                        focusedBorderStyle: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        focusColor: Colors.white,
                        label: 'password',
                        prefix: Icons.password,
                        isPassword: LoginCubit.get(context).isPassword,
                        suffix: LoginCubit.get(context).isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState
                        , builder: (context)=>defaultButton(
                              background: Colors.teal,
                        todofunction: (){
                          if(formKey.currentState!.validate())
                          {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: 'Login',
                        isUpperCase: true,
                      ),
                          fallback: (context)=> const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ? ',
                             style: TextStyle(
                               color: Colors.grey,
                             ),
                          ),
                          TextButton(
                            onPressed: (){
                              navigateTo(context, RegisterScreen());
                            },
                            child: const Text(
                                'Register Now!',
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
              ),
            ),
          ),

        );

          },

      ),
    );
  }
}
