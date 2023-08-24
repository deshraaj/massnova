
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../res/components/reusable_tile.dart';
import '../../utils/routes/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  final auth = FirebaseAuth.instance;
  TextEditingController userNameController = TextEditingController();
  ThemeMode themeMode = ThemeMode.system;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
        body: ChangeNotifierProvider(
            create: (_) => ProfileController(),
            child: Consumer<ProfileController>(
              builder: (context, provider, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 50),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: ref
                                  .child(
                                      SessionController().userId.toString())
                                  .onValue,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.snapshot.value == null) {
                                  return const Text('No data available');
                                } else if (snapshot.hasData) {
                                  final Map<dynamic, dynamic> map =
                                      snapshot.data!.snapshot.value;
                                  return Column(
                                    children: [
                                      InkWell(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 62,
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage: const NetworkImage(
                                                'https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'),
                                            foregroundImage: map['profile'] ==
                                                    ''
                                                ? null
                                                : NetworkImage(
                                                    map['profile']),
                                            // child: Image.file(
                                            //     File(provider.image!.path).absolute),
                                          ),
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                              color: const Color(0xff757575),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(15),
                                                            topLeft: Radius
                                                                .circular(
                                                                    15))),
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        'View profile photo',
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontSize:
                                                                        20,
                                                              color: AppColors.primaryTextTextColor,
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context);
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Profile Image'),
                                                              content:
                                                                  Image(
                                                                    image: map['profile']==''?const NetworkImage('https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1200-80.jpg'):NetworkImage(
                                                                        map['profile']),
                                                                  ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    InkWell(
                                                      child: Text(
                                                        'Change profile photo',
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontSize:
                                                                        20,
                                                              color: AppColors.primaryTextTextColor
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context);
                                                        provider
                                                            .showPickOption(
                                                                context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      ReusableTile(
                                        title: 'UserName',
                                        data: map['userName'],
                                        iconData: Icons.person,
                                      ),
                                      ReusableTile(
                                        title: 'Phone',
                                        data: '+91${map['phone']}',
                                        iconData: Icons.phone,
                                      ),
                                      ReusableTile(
                                        title: 'email',
                                        data: map['email'],
                                        iconData: Icons.email,
                                      ),
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      RoundButton(
                                          isLoading: false,
                                          title: 'Logout',
                                          onPressed: () {
                                            auth.signOut();
                                            Navigator.pushNamed(context, RouteName.loginScreen);
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                                          }),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      RoundButton(
                                          title: 'Edit',
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  userNameController.text = map['userName'];
                                                  // userNameController = map['userName'];
                                                  return AlertDialog(

                                                    content: TextFormField(
                                                      controller:
                                                          userNameController,
                                                      decoration: const InputDecoration(
                                                        hintText: 'Enter your new User Name'
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            provider.updateData(context, userNameController.text.toString());
                                                            userNameController.clear();
                                                          },
                                                          child:
                                                              const Text('Update'))
                                                    ],
                                                  );
                                                });
                                          })
                                    ],
                                  );
                                } else {
                                  return const Center(
                                      child: Text('Some Error Occurred'));
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}


