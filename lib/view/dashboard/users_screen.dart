

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/text_form_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashboard/chat_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';
import 'package:tech_media/view_model/theme_mode/theme_mode.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key, required this.userName,required this.profile}) : super(key: key);
  final String profile;
  final String userName;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref().child('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = '';
  String profile = '';
  ThemeMode themeMode = ThemeMode.system;
  bool isDark = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();



  
  



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final themeChanger = Provider.of<ChangeThemeMode>(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: ChangeNotifierProvider(create: (_) => ChangeThemeMode(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
            centerTitle: true,

          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormFieldComponent(hintText: 'Search..', controller: searchController, focusNode: searchFocusNode, validator: (value){return null;}, onFieldSubmitted: (newValue){}, keyboardType: TextInputType.text, icon: Icons.search,),
              ),

              Expanded(
                child: FirebaseAnimatedList(
                  query: databaseRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('userName').value.toString();
                    if (SessionController().userId.toString() !=
                        snapshot
                            .child('uid')
                            .value
                            .toString()) {
                      if (searchController.text.isEmpty){
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatScreen(
                                        uid: snapshot
                                            .child('uid')
                                            .value
                                            .toString(),
                                      ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: snapshot
                                  .child('profile')
                                  .value
                                  .toString() ==
                                  ''
                                  ? const NetworkImage(
                                  'https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'
                              )
                                  : NetworkImage(
                                  snapshot
                                      .child('profile')
                                      .value
                                      .toString()),
                            ),
                            title: Text(snapshot
                                .child('userName')
                                .value
                                .toString()),
                            subtitle: Text(snapshot
                                .child('email')
                                .value
                                .toString()),
                          ),
                        );
                      }
                      else if(title.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatScreen(
                                        uid: snapshot
                                            .child('uid')
                                            .value
                                            .toString(),
                                      ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: snapshot
                                  .child('profile')
                                  .value
                                  .toString() ==
                                  ''
                                  ? const NetworkImage(
                                  'https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'
                              )
                                  : NetworkImage(
                                  snapshot
                                      .child('profile')
                                      .value
                                      .toString()),
                            ),
                            title: Text(snapshot
                                .child('userName')
                                .value
                                .toString()),
                            subtitle: Text(snapshot
                                .child('email')
                                .value
                                .toString()),
                          ),
                        );
                      }
                      else{
                        return Container();
                      }

                    } else {
                      // userName = snapshot
                      //     .child('userName')
                      //     .value
                      //     .toString();
                      // profile = snapshot
                      //     .child('profile')
                      //     .value
                      //     .toString();
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
          drawer: SafeArea(
            child: Drawer(
              width: (size.width) * (0.6),
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,

                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: widget.profile==''?const NetworkImage(
                        'https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'
                    ):NetworkImage(widget.profile),
                    radius: 30,
                    backgroundColor: AppColors.primaryMaterialColor,
                  ),
                  Center(
                    child: Text(
                      widget.userName,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouteName.profileScreen);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      _auth.signOut().then((value) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, RouteName.loginScreen);
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text('Contact us'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouteName.contactScreen);

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.nightlight),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: ThemeMode.dark == themeChanger.themeMode,
                      onChanged: (bool value) {
                        if (themeChanger.themeMode == ThemeMode.dark){
                          themeChanger.changeTheme(ThemeMode.light);
                        }
                        else if (themeChanger.themeMode == ThemeMode.system){
                          themeChanger.changeTheme(ThemeMode.dark);
                        }
                        else{
                          themeChanger.changeTheme(ThemeMode.dark);
                        }

                      },
                    ),
                  ),
                  const ListTile(
                    title: Text('Team Mass Nova'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
