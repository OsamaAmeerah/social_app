// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp2/Layout/social_app/cubit/states.dart';
import 'package:socialapp2/models/user_model.dart';
import 'package:socialapp2/modules/new_post/new__post_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../components/deafult_components.dart';
import '../../../models/message_model.dart';
import '../../../models/post_model.dart';
import '../../../modules/chats/chats_screen.dart';
import '../../../modules/feeds/feeds_screen.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../../modules/users/users_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataLoadingStates());

    fireStore.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Settings',
  ];
  List<Widget>items=[
    const Icon(Icons.home),
    const Icon(Icons.chat),
    const Icon(Icons.upload,
      size: 30.0,
    ),
    const Icon(Icons.settings),
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostStates());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarStates());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessStates());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  // image_picker7901250412914563370.jpg

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessStates());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorStates());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageSuccessStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }


  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
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
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async
  {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessStates());
    }
    else
    {
      print('No image selected');
      emit(SocialPostImagePickedErrorStates());
    }
  }
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
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
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
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
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    fireStore
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    fireStore.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      }

      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }

  void likePost(String postId) {
    fireStore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostsErrorStates(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    if (users.isEmpty)
      // ignore: curly_braces_in_flow_control_structures
      fireStore.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }

        emit(SocialGetAllUsersSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorStates(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

         fireStore
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessagesErrorStates(error.toString()));
    });

    // set receiver chats

         fireStore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessagesErrorStates(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    messages = [];
        fireStore
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

      emit(SocialGetMessagesSuccessStates());
    });
  }
}