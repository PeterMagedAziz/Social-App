import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/social_layout.dart';
import 'package:share/shared/network/local/cache_helper.dart';
import '../../shared/component/component.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: 'Something is Wrong', state: ToastStates.ERROR);

          }else {
            if (state is SocialLoginSuccessState) {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateToAndFinish(context, const SocialLayout());
              });
              showToast(text: 'Login Successful', state: ToastStates.SUCCESS);
            }
          }

          // if (state is SocialLoginSuccessState) {
          //   if (state.loginModel.status!) {
          //     // Print For Test
          //     print(state.loginModel.message);
          //     print(state.loginModel.data!.token);
          //     CacheHelper.saveData(
          //       key: 'token',
          //       value: state.loginModel.data!.token,
          //     ).then((value) {
          //       token = state.loginModel.data!.token;
          //       navigateReplacementTo(
          //         context,
          //         const SocialLayoutScreen(),
          //       );
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
          var cubit = SocialLoginCubit.get(context);
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Login".toUpperCase(),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: Colors.blueGrey,
                                fontSize: 30
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Login now to Communicate with Friends",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.white54,
                                fontSize: 20,
                              ),
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
                                if (value.isEmpty) {
                                  return "Please Enter Your Email Address";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultTextFormField(
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              obscureText: cubit.isPassword,
                              controller: passwordController,
                              prefixIcon: Icons.lock,
                              suffixIcon: cubit.suffix,
                              suffixPressed: () => cubit
                                  .changePasswordVisibility(),
                              labelText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              validation: (value) {
                                if (value.isEmpty) {
                                  return "Please Enter Your Password";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => defaultElevatedButton(
                                text: "Login",
                                borderRadius: 10.0,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don\'t have an account?",style: TextStyle(
                                  color: Colors.white
                                ),),
                                defaultTextButton(
                                  text: "Register",
                                  function: () => navigateReplacementTo(
                                    context,
                                    const SocialRegisterScreen(),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
