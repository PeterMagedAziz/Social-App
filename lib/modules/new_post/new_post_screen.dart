import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/shared/component/component.dart';

class NewPostScreen extends StatelessWidget {

  const NewPostScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context ,) {
    var textController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyBroken.arrowLeft2),
            ),
            actions: [defaultTextButton(
                function: ()
            {
              var now = DateTime.now();

              if(SocialCubit.get(context).postImage == null) {
                SocialCubit.get(context).createPost
                  (
                    dateTime: now.toString(),
                    text: textController.text,
                );
              }else{
                SocialCubit.get(context).uploadPostImage
                  (
                    dateTime: now.toString(),
                    text: textController.text
                );
              }
            }, text: 'Post')],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if(states is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
                if(states is SocialCreatePostLoadingState)
                const SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              Text(
                                '${SocialCubit.get(context).userModel!.name}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'What is in your mind ....',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 10,),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 250 ,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15.0,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: const [
                            Icon(IconlyBroken.image),
                            SizedBox(
                              width:
                              5.0,
                            ),
                            Text('add Photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('#Tags',style: TextStyle(
                            fontSize: 15.0
                        ),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
