import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share/layout/cubit/cubit.dart';
import 'package:share/layout/cubit/states.dart';
import 'package:share/shared/component/component.dart';

import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${userModel!.cover}'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 54.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            '${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              Text('${userModel.name}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 19,
                  fontWeight: FontWeight.w500
                ),),
              const SizedBox(
                height: 6,
              ),
              Text('${userModel.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 17,
                )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 6,
                            ),
                            Text('Posts',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('541',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 6,
                            ),
                            Text('Photos',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 6,
                            ),
                            Text('Followers',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('64',
                                style: Theme.of(context).textTheme.subtitle2),
                            const SizedBox(
                              height: 6,
                            ),
                            Text('Followings',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton
                      (onPressed: (){},
                        child: const Text('Add Photos'),),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton
                    (onPressed: (){
                      navigateTo(context, const EditProfileScreen());
                  },
                    child: const Icon(IconlyBroken.edit,
                    size: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
