abstract class SocialStates{}
// initial state
class SocialInitialStates extends SocialStates{}
//get user data
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserDataLoadingStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{
  final String error;
  SocialGetUserErrorStates(this.error);

}
// bottom nav bar
class ChangeBottomNavBarStates extends SocialStates{}

//pick profile image states
class SocialProfileImagePickedSuccessStates extends SocialStates{}
class SocialProfileImagePickedErrorStates extends SocialStates{}
//pick cover image states
class SocialCoverImagePickedSuccessStates extends SocialStates{}
class SocialCoverImagePickedErrorStates extends SocialStates{}
//pick post image states
class SocialPostImagePickedSuccessStates extends SocialStates{}
class SocialPostImagePickedErrorStates extends SocialStates{}
//upload profile image
class SocialUploadProfileImageSuccessStates extends SocialStates{}
class SocialUploadProfileImageErrorStates extends SocialStates{}
//upload cover
class SocialUploadCoverImageSuccessStates extends SocialStates{}
class SocialUploadCoverImageErrorStates extends SocialStates{}
//update user data
class UserUpdateErrorState extends SocialStates{}
class UserUpdateLoadingState extends SocialStates{}
//create posts
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialNewPostStates extends SocialStates{}
//remove image from post state
class SocialRemovePostImageState extends SocialStates{}
//get posts states
class SocialGetPostsSuccessStates extends SocialStates{}
class SocialGetPostsLoadingStates extends SocialStates{}
class SocialGetPostsErrorStates extends SocialStates{
  final String error;
  SocialGetPostsErrorStates(this.error);

}
// like posts states
class SocialLikePostsSuccessStates extends SocialStates{}
class SocialLikePostsErrorStates extends SocialStates{
  final String error;
  SocialLikePostsErrorStates(this.error);

}
// comment states
class SocialCommentSuccessStates extends SocialStates{}
class SocialCommentErrorStates extends SocialStates{
  final String error;
  SocialCommentErrorStates(this.error);

}

// get all users
class SocialGetAllUsersSuccessStates extends SocialStates{}
class SocialGetAllUsersLoadingStates extends SocialStates{}
class SocialGetAllUsersErrorStates extends SocialStates{
  final String error;
  SocialGetAllUsersErrorStates(this.error);

}
//get message states
class SocialGetMessagesSuccessStates extends SocialStates{}
// send message states
class SocialSendMessagesSuccessStates extends SocialStates{}
class SocialSendMessagesErrorStates extends SocialStates{
  final String error;
  SocialSendMessagesErrorStates(this.error);

}