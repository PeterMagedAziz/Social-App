// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:dialog/dialogs/modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:share/layout/cubit/cubit.dart';
//
// import '../../layout/cubit/states.dart';
// import '../../models/comment_model.dart';
// import '../../models/user_model/social_user_model.dart';
// import '../../shared/style/iconly/iconly_broken.dart';
//
// class CommentScreen extends StatelessWidget {
//   final textCommentController = TextEditingController();
//   final String uIdIndex;
//   final SocialUserModel? userModel;
//   final CommentModel? model;
//
//
//
//   CommentScreen(this.uIdIndex, {super.key, this.userModel, this.model});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, states) {},
//       builder: (context, states) {
//         return Builder(
//           builder: (BuildContext context) {
//             return  BlocConsumer<SocialCubit,SocialStates>(
//               listener: (context,state){},
//               builder: (context,state){
//                 return Scaffold(
//                   appBar: AppBar(
//                     titleSpacing: 0.0,
//                     title: Row(
//                       children: const [
//                         Text('Comments'),
//                       ],
//                     ),
//                   ),
//                   body: ConditionalBuilder(
//                     condition: SocialCubit.get(context).messages.isNotEmpty,
//                     builder: (context) => Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: ListView.separated(
//                                 physics: const BouncingScrollPhysics(),
//                                 itemBuilder: (context,index) {
//                                   return commentItem(context,model!,index);
//                                 } ,
//                                 separatorBuilder: (context,index) => const SizedBox(
//                                   height: 15,
//                                 ),
//                                 itemCount: SocialCubit.get(context).messages.length
//                             ),
//                           ),
//                           const SizedBox(height: 10,),
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1
//                                 ),
//                                 borderRadius: BorderRadius.circular(15)
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 15.0,right: 5.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: TextFormField(
//                                       decoration: const InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: 'type your message here ...',
//                                       ),
//                                       controller: textCommentController,
//                                     ),
//                                   ),
//                                   MaterialButton(
//                                     onPressed: (){
//                                       SocialCubit.get(context).sendMessage(
//                                           receiverId: userModel!.uId,
//                                           dateTime: DateTime.now().toString(),
//                                           text: textCommentController.text
//                                       );
//                                     },
//                                     minWidth: 1,
//                                     child: const Icon(
//                                       IconlyBroken.send,
//                                       size: 20.0,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     fallback: (context) => const Center(child: CircularProgressIndicator()),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
//
//
//   Widget commentItem(context, CommentModel model, index) {
//     return Column(
//       children: [
//         if (model.postId == uIdIndex)
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 radius: 30.0,
//                 backgroundImage: NetworkImage("${model.image}"),
//               ),
//               const SizedBox(
//                 width: 10.0,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           '${model.name}',
//                           style:
//                               Theme.of(context).textTheme.bodyText1!.copyWith(
//                                     fontSize: 18.0,
//                                     color: Colors.black,
//                                     height: 1.0,
//                                   ),
//                         ),
//                         const SizedBox(
//                           width: 10.0,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 7.0,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       child: Text(
//                         '${model.textComment}',
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                             height: 1.6, fontSize: 15, color: Colors.grey[700]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }
