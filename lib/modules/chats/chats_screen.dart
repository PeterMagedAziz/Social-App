import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/models/user_model.dart';
import 'package:share/models/user_model/social_user_model.dart';
import 'package:share/shared/component/component.dart';

import '../chats_details/chat_details.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,states){},
      builder: (context,states){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder:(context,index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildChatItem (SocialUserModel model,context,) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model),);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children:  [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
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
    ),
  );
}
