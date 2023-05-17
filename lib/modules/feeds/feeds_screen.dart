import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:share/shared/component/component.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: const EdgeInsets.all(8),
            child: Stack(alignment: Alignment.bottomRight, children: const [
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
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/successful-dark-skinned-female-student-happy-get-scholarship-clenches-fists-accomplishes-goal_273609-25984.jpg?t=st=1684320863~exp=1684321463~hmac=1b15397c9a8deb15ce70a96e4e61787f2eb6e0589ec1a34ed84694dd36ea5078'),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Peter Maged',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                  size: 15,
                                ),
                              ],
                            ),
                            const Text(
                              'May 17, 2023 at 7:49 pm',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
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
                  const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 5,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: SizedBox(
                              height: 20,
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  '#software',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: SizedBox(
                              height: 20,
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  '#software_developemnet',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: SizedBox(
                              height: 20,
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  '#Flutter',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: SizedBox(
                              height: 20,
                              child: MaterialButton(
                                onPressed: () {},
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  '#Dart',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?w=996&t=st=1684320863~exp=1684321463~hmac=f2d09bb26778bea26fed12f19f7131e46e51f53ca9701055b8c9de7f48b0d575'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3,left: 3),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children:  [
                                  const Icon(IconlyBroken.heart,
                                  size: 20,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text('1200',
                                    style: TextStyle(
                                      color: Colors.grey[700]
                                    ),
                                  )

                                ],
                              ),
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:  [
                                  const Icon(IconlyBroken.chat,
                                  size: 20,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text('1200',
                                    style: TextStyle(
                                      color: Colors.grey[700]
                                    ),
                                  )

                                ],
                              ),
                            ),
                            onTap: (){},
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
                    children:
                    [
                      Expanded(
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-photo/successful-dark-skinned-female-student-happy-get-scholarship-clenches-fists-accomplishes-goal_273609-25984.jpg?t=st=1684320863~exp=1684321463~hmac=1b15397c9a8deb15ce70a96e4e61787f2eb6e0589ec1a34ed84694dd36ea5078'),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('write a comment ....',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                            ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10,right: 10),
                          child: Row(
                            children:  [
                              const Icon(IconlyBroken.heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text('Like',
                                style: TextStyle(
                                    color: Colors.red[700]
                                ),
                              )

                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10,right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:  [
                              const Icon(IconlyBroken.moreSquare,
                                size: 20,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text('Share',
                                style: TextStyle(
                                    color: Colors.blue
                                ),
                              )

                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
