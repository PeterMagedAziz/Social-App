import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/models/post_model.dart';
import 'package:share/modules/chats/chats_screen.dart';
import 'package:share/modules/feeds/feeds_screen.dart';
import 'package:share/modules/new_post/new_post_screen.dart';
import 'package:share/modules/settings/settings_screen.dart';
import 'package:share/modules/users/user_screen.dart';
import 'package:share/shared/component/constants.dart';
import '../../models/comment_model.dart';
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

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//     required String name,
//     required String phone,
//     required String bio,
//   }) {
//     emit(SocialUpdateUserLoadingState());
//     if (coverImage != null)
//     {
//       uploadCoverImage();
//     }
//     if (profileImage != null)
//     {
//       uploadProfileImage();
//     }
//     else if (coverImage != null && profileImage != null)
//     {
//     } else {
//       updateUser(name: name, phone: phone, bio: bio);
// }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
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

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImagePickedState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }


  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference
        .collection('likes')
        .get()
        .then((value) {
          likes.add(value.docs.length);
          // postId.add(element.id);
          // posts.add(PostModel.fromJson(element.data()));
        })
        .catchError((error){});

        element.reference
        .collection('comments')
        .get()
        .then((value) {
          comments.add(value.docs.length);
          // postId.add(element.id);
          // posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){});
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));

      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like':true})
        .then((value) {
      emit(SocialLikePostSuccessState());
    })
        .catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }
  void commentsPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comments':true})
        .then((value) {
      emit(SocialCommentsPostSuccessState());
    })
        .catchError((error) {
      emit(SocialCommentsPostErrorState(error.toString()));
    });
  }


}
