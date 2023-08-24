import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/text_form_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/chat/chat_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../res/components/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseReference userRef = FirebaseDatabase.instance.ref('Users');
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController postController = TextEditingController();
  FocusNode postFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DatabaseReference myPostRef = FirebaseDatabase.instance
        .ref('Post')
        .child(SessionController().userId.toString())
        .child(widget.uid);
    DatabaseReference userPostRef = FirebaseDatabase.instance
        .ref('Post')
        .child(widget.uid)
        .child(SessionController().userId.toString());

    Future sendMessage(
        {required String message, required String sender}) async {
      String id = (9999999999999 - DateTime.now().millisecondsSinceEpoch).toString();
      myPostRef.child(id).set({'message': message, 'id': id, 'sender': sender});
      userPostRef
          .child(id)
          .set({'message': message, 'id': id, 'sender': sender});
      postController.clear();
    }

    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder(
        stream: userRef.child(widget.uid).onValue,
        builder: (context, AsyncSnapshot snapshot) {
          try{
            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(map['profile']),
                child: const Icon(Icons.person),
              ),
              title: Text(map['userName']),
              subtitle: Text(map['email']),
            );
          }catch(e){
            return Container();
          }

        },
      )),
      body: ChangeNotifierProvider(
        create: (_)=>ChatController(),
        child: Consumer<ChatController>(
          builder: (context,provider,child){
            return Column(
              children: [
                Expanded(
                    child: FirebaseAnimatedList(
                      query: myPostRef,
                      reverse: true,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return MessageBubbles(
                            text: snapshot.child('message').value.toString(),
                            isMe: snapshot.child('sender').value.toString() ==
                                auth.currentUser!.email.toString());
                        //Text(snapshot.child('message').value.toString());
                      },
                    )),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.photo,
                      color: AppColors.primaryMaterialColor,
                    ),
                    onPressed: () {
                      provider.showPickOption(context, widget.uid);
                    },
                  ),
                  title: Form(
                    key: _formKey,
                    child: TextFormFieldComponent(
                      hintText: 'Write something here...',
                      controller: postController,
                      focusNode: postFocusNode,
                      validator: (value) {
                        return value.isEmpty ? 'Write something' : null;
                      },
                      onFieldSubmitted: (newValue) {
                        Utils.fieldFocus(context, postFocusNode, null);
                      },
                      keyboardType: TextInputType.text,
                      icon: Icons.message,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.primaryMaterialColor,
                    ),
                    onPressed: () {
                      sendMessage(
                          message: postController.text.toString(),
                          sender: auth.currentUser!.email.toString());
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
