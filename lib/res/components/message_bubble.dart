import 'package:flutter/material.dart';

import '../color.dart';





class MessageBubbles extends StatelessWidget {
  const MessageBubbles(
      {super.key, required this.text, required this.isMe});

  final String text;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe
                  ? const Radius.circular(10.0)
                  : const Radius.circular(0.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
              topRight: !isMe
                  ? const Radius.circular(10.0)
                  : const Radius.circular(0.0),
            ),
            elevation: 5,
            color: isMe ? AppColors.primaryMaterialColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              child: text.contains('https:')
                  ? Image.network(text,width: size.width*0.5,)
                  : Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}