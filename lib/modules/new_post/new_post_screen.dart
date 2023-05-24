import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        titleSpacing: 0.0,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(IconlyBroken.arrowLeft2),
        ),
      ),
    );
  }
}
