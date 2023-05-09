import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/social_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});



  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            navigateToAndFinish(context, const SocialLayout());
          }
          // if (state is SocialRegisterSuccessState) {
          //   if (state.loginModel.status!) {
          //     // Print For Test
          //     print(state.login Model.message);
          //     print(state.loginModel.data!.token);
          //     CacheHelper.saveData(
          //       key: 'token',
          //       value: state.loginModel.data!.token,
          //     ).then((value) {
          //       token = state.loginModel.data!.token;
          //       navigateReplacementTo(context,  SocialLayoutScreen());
          //     });
          //     showToast(
          //       text: state.loginModel.message!,
          //       state: ToastStates.SUCCESS,
          //     );
          //   } else {
          //     // Print For Test
          //     print(state.loginModel.message);
          //     showToast(
          //       text: state.loginModel.message!,
          //       state: ToastStates.ERROR,
          //     );
          //   }
          // }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            body: Container(
              decoration:  const BoxDecoration(
                image: DecorationImage
                  (image: AssetImage
                  ('assets/images/fog-on-dark-waters-edge.jpg'),
                    fit: BoxFit.cover
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Register".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.blueGrey
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            "Register now to Communicate with Friends",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white38,
                              fontSize: 20
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            prefixIcon: Icons.person_outline,
                            labelText: "User Name",
                            keyboardType: TextInputType.name,
                            validation: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Name";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            prefixIcon: Icons.email,
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            validation: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email Address";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            obscureText: cubit.isPassword,
                            controller: passwordController,
                            prefixIcon: Icons.password,
                            suffixIcon: cubit.suffix,
                            suffixPressed: () => cubit
                                .changePasswordVisibility(),
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            validation: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Password";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            controller: phoneController,
                            prefixIcon: Icons.phone,
                            labelText: "Phone",
                            keyboardType: TextInputType.visiblePassword,
                            validation: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Your Phone";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => defaultElevatedButton(
                              text: "register",
                              borderRadius: 15.0,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
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
