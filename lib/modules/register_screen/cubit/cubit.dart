import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/models/user_model/social_user_model.dart';
import 'package:share/modules/register_screen/cubit/states.dart';




class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone ,
    required String email,
    required String password,
  }) {
    print('hello');
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          phone: phone,
          email: email,
          uId: value.user!.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState());
    });

  }

  void userCreate({
    required String name,
    required String phone ,
    required String email,
    required String uId,

  })
  {
    SocialUserModel model = SocialUserModel
      (
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
          emit(SocialCreateUserErrorState());
    });

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibilityState());
  }
}
