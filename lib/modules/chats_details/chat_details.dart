import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/models/user_model/social_user_model.dart';
import 'package:share/shared/network/styles/colors.dart';

import '../../shared/style/iconly/iconly_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
 final SocialUserModel? userModel;


   ChatDetailsScreen({super.key, this.userModel});

  var messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('${userModel!.image}'),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text('${userModel!.name}'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                buildMessage(),
                buildMyMessage(),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message here ...',
                            ),
                            controller: messageController,
                          ),
                        ),
                        MaterialButton(
                          onPressed: (){
                            SocialCubit.get(context).sendMessage(
                                receiverId: userModel!.uId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text
                            );
                          },
                          minWidth: 1,
                          child: const Icon(
                            IconlyBroken.send,
                            size: 20.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildMessage() => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:  BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0
      ),
      child: const Text('Hello'),
    ),
  );
  Widget buildMyMessage() =>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:  BoxDecoration(
          color: defaultColor.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0
      ),
      child: const Text('Hello There'),
    ),
  );
}