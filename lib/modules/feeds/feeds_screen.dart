import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/models/post_model.dart';
import 'package:share/shared/component/component.dart';
import '../../layout/cubit/cubit.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(8),
                  child:
                  Stack(alignment: Alignment.bottomRight, children: const [
                    Image(
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?w=996&t=st=1684320863~exp=1684321463~hmac=f2d09bb26778bea26fed12f19f7131e46e51f53ca9701055b8c9de7f48b0d575'),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with Friends',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ]),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/cheerful-curly-blond-woman-glittery-disco-top-looks-amazement-camera-lilac-space_197531-15568.jpg?w=996&t=st=1685441305~exp=1685441905~hmac=4aed6efddfae6af8048748ad975248001ff2353a1c43cce0eb54bb4237e8bf65'),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
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
                    Text(
                      '${model.dateTime}',
                      style:
                      const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined))
            ],
          ),
          myDivider(),
          Text(
            '${model.text}',
            style: const TextStyle(
              height: 1.5,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10,
          //     top: 5,
          //   ),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: SizedBox(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: SizedBox(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#software_developemnet',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: SizedBox(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#Flutter',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 5),
          //           child: SizedBox(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: const Text(
          //                 '#Dart',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                child: Container(
                  height: 350,
                  width: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 4),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          IconlyBroken.heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        if (SocialCubit.get(context).likes.length > index)
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconlyBroken.chat,
                          size: 20,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        if (SocialCubit.get(context).comments.length > index)
                          Text(
                            '${SocialCubit.get(context).comments[index]}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            width: double.infinity,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      child: const Text(
                        'write a comment ....',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      onTap: () {
                        SocialCubit.get(context)
                            .commentsPost(SocialCubit.get(context).postId[index]);
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        IconlyBroken.heart,
                        size: 20,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Like',
                        style: TextStyle(color: Colors.grey[700]),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  SocialCubit.get(context)
                      .likePost(SocialCubit.get(context).postId[index]);
                },
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              // InkWell(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 10,right: 4),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children:  const [
              //         Icon(IconlyBroken.moreSquare,
              //           size: 20,
              //           color: Colors.blue,
              //         ),
              //         SizedBox(
              //           width: 3,
              //         ),
              //         Text('Share',
              //           style: TextStyle(
              //               color: Colors.blue
              //           ),
              //         )
              //
              //       ],
              //     ),
              //   ),
              //   onTap: (){},
              // ),
            ],
          ),
        ],
      ),
    ),
  );
}