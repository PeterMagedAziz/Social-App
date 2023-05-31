abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialGetMessageLoginState extends SocialStates{}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}
class SocialGetUserPostsLengthSuccessState extends SocialStates{}

class SocialGetUserPostsLengthErrorState extends SocialStates{
  final String error;

  SocialGetUserPostsLengthErrorState(this.error);
}

class SocialPostLikesLoadingState extends SocialStates {}

class SocialPostLikesSuccessState extends SocialStates {}

class SocialPostLikesErrorState extends SocialStates {
  final String error;

  SocialPostLikesErrorState(this.error);
}

class SocialCreateCommentLoadingStates extends SocialStates {}

class SocialCreateCommentSuccessStates extends SocialStates {}

class SocialCreateCommentErrorStates extends SocialStates {}

class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialUploadCommentImageErrorStates extends SocialStates {}

class SocialGetCommentsLoadingState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates {
  final String error;

  SocialGetCommentsErrorState(this.error);
}

class SocialCommentsPostSuccessState extends SocialStates{}

class SocialCommentsPostErrorState extends SocialStates{
  final String error;

  SocialCommentsPostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{}

//Create Post

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialRemovePostImagePickedState extends SocialStates{}
