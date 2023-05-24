import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/modules/new_post/new_post_screen.dart';
import 'package:share/shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, states) {
          var cubit = SocialCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyBroken.notification),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyBroken.search),
                  ),
                ],
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: [

                  SalomonBottomBarItem(
                    icon: const Icon(IconlyBroken.home),
                    title: const Text("Home"),
                    selectedColor: Colors.purple,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(IconlyBroken.chat),
                    title: const Text("Chat"),
                    selectedColor: Colors.pink,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(IconlyBroken.paperUpload),
                    title: const Text("Post"),
                    selectedColor: Colors.blue,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(IconlyBroken.user2),
                    title: const Text("User"),
                    selectedColor: Colors.orange,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(IconlyBroken.setting),
                    title: const Text("Settings"),
                    selectedColor: Colors.teal,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is SocialNewPostState){
            navigateTo (context,const NewPostScreen());
          }
        });
  }
}
