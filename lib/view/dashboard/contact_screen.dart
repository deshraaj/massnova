import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Help and support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/images/my_new_logo.png')),
              Text(
                '😔 Sorry to see you here!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'If you have any issue regarding setting, UI, sending message, theme mode, users, profile or anything, Please let us know.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Feel free to reach us at anytime',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    text: 'Call - ',
                    children: [
                      TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue),
                          text: '8418977473')
                    ]),
              ),
              Text.rich(
                TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    text: 'E-mail  -  ',
                    children: [
                      TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue),
                          text: 'deshrajsingh769735@gmail.com')
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
