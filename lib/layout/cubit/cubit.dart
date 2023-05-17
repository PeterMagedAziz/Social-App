import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/modules/chats/chats_screen.dart';
import 'package:share/modules/feeds/feeds_screen.dart';
import 'package:share/modules/settings/settings_screen.dart';
import 'package:share/modules/users/user_screen.dart';
import 'package:share/shared/component/constants.dart';
import '../../models/user_model/social_user_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(uId).get().then((value) {
          // print(value.data());
      model = SocialUserModel.fromJson(value.data()?.cast<String, dynamic>() ?? {});
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex =0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UserScreen(),
    const SettingsScreen()

  ];

  List<String> titles= [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }
}
