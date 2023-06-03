import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/models/message_model.dart';
import 'package:share/models/post_model.dart';
import 'package:share/modules/chats/chats_screen.dart';
import 'package:share/modules/feeds/feeds_screen.dart';
import 'package:share/modules/new_post/new_post_screen.dart';
import 'package:share/modules/settings/settings_screen.dart';
import 'package:share/modules/users/user_screen.dart';
import 'package:share/shared/component/constants.dart';
import 'package:share/shared/network/local/cache_helper.dart';
import '../../models/comment_model.dart';
import '../../models/user_model/social_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  String? uIdIndex;

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
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  bool isDarkModeEnabled=false;
  ThemeMode appMode = ThemeMode.dark;


  void changeAppMode ({bool? fromShared})
  {

    fromShared !=null ? isDarkModeEnabled =fromShared : isDarkModeEnabled = !isDarkModeEnabled;
    CacheHelper.saveData(key: 'isDark', value: isDarkModeEnabled).then((value) {
      print(value);
      emit(ChangeModeSocialAppStates());
    });

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
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          // postId.add(element.id);
          // posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});

        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          // postId.add(element.id);
          // posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
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
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentsPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comments': true}).then((value) {
      emit(SocialCommentsPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentsPostErrorState(error.toString()));
    });
  }

  XFile? commentImage;
  File? commentImageFile;
  Future<void> getCommentImage() async {
    commentImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (commentImage != null) {
      commentImageFile = File(commentImage!.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void uploadCommentImage({
    required String uidComment,
    required String textComment,
    String? postId,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("comments/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createComment(
          uidComment: uidComment,
          textComment: textComment,
          imageComment: value,
          postId: postId!,
        );
      }).catchError((error) {
        emit(SocialUploadCommentImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCommentImageErrorStates());
    });
  }

  void createComment({
    required String uidComment,
    required String textComment,
    String? imageComment,
    String? postId,
  }) {
    emit(SocialCreateCommentLoadingStates());
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      textComment: textComment,
      image: userModel!.image,
      uId: userModel!.uId,
      imageComment: imageComment,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uidComment)
        .collection("comments")
        .doc(userModel!.uId)
        .set(commentModel.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessStates());
    }).catchError((error) {
      emit(SocialCreateCommentErrorStates());
    });
  }

  List<CommentModel> commentsModel = [];
  List<String> postsIdComment = [];


  void getComments() {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          postsIdComment.add(element.id);
          commentsModel.add(CommentModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetCommentsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetCommentsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error));
      });
    }
  }

  void sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));

          }
          emit(SocialGetMessageSuccessState());
    });
  }
}
