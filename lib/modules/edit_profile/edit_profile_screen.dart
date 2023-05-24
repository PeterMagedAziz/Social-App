import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/shared/component/component.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();

        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var userModel = SocialCubit.get(context).userModel;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconlyBroken.arrowLeft2),
              ),
              actions: [
                defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  text: 'Update',
                ),
                const SizedBox(
                  width: 15.0,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (states is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15.0,
                                  child: Icon(
                                    IconlyBroken.camera,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 54.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15.0,
                                child: Icon(
                                  IconlyBroken.edit,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  defaultTextFormField(
                    controller: nameController,
                    prefixIcon: IconlyBroken.user2,
                    labelText: "User Name",
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Name";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    prefixIcon: IconlyBroken.call,
                    labelText: "User Phone",
                    keyboardType: TextInputType.phone,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Phone Number";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    prefixIcon: IconlyBroken.infoSquare,
                    labelText: "User BIO",
                    keyboardType: TextInputType.text,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your bio";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
