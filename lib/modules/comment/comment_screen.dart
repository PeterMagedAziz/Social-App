import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';

import '../../models/comment_model.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen(this.uIdIndex, {super.key});
  var textCommentController = TextEditingController();
  String uIdIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);

        return Scaffold(appBar: AppBar(), body: const Text("Comments"));
      },
    );
  }

  Widget commentItem(context, CommentModel model, index) {
    return Column(
      children: [
        if (model.postId == uIdIndex)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    height: 1.0,
                                  ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        '${model.textComment}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            height: 1.6, fontSize: 15, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
