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
          uId: value.user!.uid,
      );
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
        bio: 'Write Your Bio ....',
        cover: 'https://img.freepik.com/free-photo/portrait-cheerful-pleasant-bearded-guy-showing-direction-with-his-forefinger-having-sincere-smile_176532-10248.jpg?t=st=1684415775~exp=1684416375~hmac=65557ff7db94541c34eb758db127e729d3f10564d48b566adfbf047af35f9cd5',
        image: 'https://img.freepik.com/free-photo/indoor-picture-cheerful-handsome-young-man-having-folded-hands-looking-directly-smiling-sincerely-wearing-casual-clothes_176532-10257.jpg?w=996&t=st=1684415744~exp=1684416344~hmac=3d314a653679854d6398f7962b78624bc1195fc21dbb3b619e488efe01ffdc6e',
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
