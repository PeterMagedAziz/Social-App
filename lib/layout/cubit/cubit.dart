import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/modules/chats/chats_screen.dart';
import 'package:share/modules/feeds/feeds_screen.dart';
import 'package:share/modules/new_post/new_post_screen.dart';
import 'package:share/modules/settings/settings_screen.dart';
import 'package:share/modules/users/user_screen.dart';
import 'package:share/shared/component/constants.dart';
import '../../models/user_model/social_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel =
          SocialUserModel.fromJson(value.data()?.cast<String, dynamic>() ?? {});
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UserScreen(),
    const SettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }
  //data/user/0/com.example.share/cache/02a0ef16-1f49-4b84-8d28-db7abb06510d/portrait-satisfied-young-man-celebrating-success (1).jpg
  //portrait-satisfied-young-man-celebrating-success.

  String profileImageUrl = '';

  void uploadProfileImage() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          emit(SocialUploadProfileImageSuccessState());
          print(value);
          profileImageUrl = value;
        }).catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    } else {
      print('Error: profileImage is null');
    }
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        coverImageUrl = value;
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserImages({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    if (coverImage != null)
    {
      uploadCoverImage();
    }
    if (profileImage != null)
    {
      uploadProfileImage();
    }
    else if (coverImage != null && profileImage != null)
    {
    } else {
      updateUser(name: name, phone: phone, bio: bio);
}
  }
  void updateUser({
    required String name,
    required String phone,
    required String bio,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: userModel!.cover,
      image: userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }
}
