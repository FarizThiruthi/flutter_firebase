import 'package:flutter/material.dart';
import 'package:flutter_forebase/methods/authentication.dart'; // Import your Authentication class

class WishPage extends StatelessWidget {
  const WishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
        actions: [
          CircleAvatar(
            child: Text(0.toString()),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            // Call the logOut method from your Authentication class
            Authentication.instance.logOut();
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextButton(onPressed: () {}, child: const Text('WishList'))),
              Expanded(
                  child:
                      TextButton(onPressed: () {}, child: const Text('Fulfilled'))),
            ],
          )
        ],
      ),
    );
  }
}
