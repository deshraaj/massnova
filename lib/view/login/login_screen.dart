
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/text_form_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../utils/routes/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _forgotKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController resetPasswordController = TextEditingController();
  FocusNode resetPasswordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/chat_app_icon.png'),
                      height: height * .1,
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text(
                      'Welcome to MASS NOVA',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    SizedBox(
                      height: height * .1,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormFieldComponent(
                            icon: Icons.email,
                            hintText: 'Enter your email',
                            controller: emailController,
                            focusNode: emailFocusNode,
                            validator: (value) {
                              return value.isEmpty ? 'Enter your email' : null;
                            },
                            onFieldSubmitted: (newValue) {
                              Utils.fieldFocus(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormFieldComponent(
                            icon: Icons.password,
                            obscureText: true,
                            hintText: 'Enter your password',
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            validator: (value) {
                              return value.isEmpty ? 'Enter your password' : null;
                            },
                            onFieldSubmitted: (newValue) {
                              Utils.fieldFocus(context, passwordFocusNode, null);
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext) {
                            return AlertDialog(
                              title: const Text('Enter your registered e-Mail'),
                              content: Form(
                                key: _forgotKey,
                                child: TextFormFieldComponent(
                                  hintText: 'Enter your email',
                                  controller: resetPasswordController,
                                  focusNode: resetPasswordFocusNode,
                                  validator: (value) {
                                    return value.isEmpty
                                        ? 'Enter your email'
                                        : null;
                                  },
                                  onFieldSubmitted: (newValue) {
                                    Utils.fieldFocus(context, resetPasswordFocusNode, null);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  icon: Icons.email,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () { Navigator.pop(context); },
                                  child: Text(
                                    'Cancle',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: 17),
                                  ),
                                ),
                                TextButton(
                                  child: Text(
                                    'Send',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  onPressed: () {
                                    if (_forgotKey.currentState!.validate()) {
                                      auth
                                          .sendPasswordResetEmail(
                                        email:
                                        resetPasswordController.text.toString(),
                                      )
                                          .then((value) {
                                        Utils.toastMessage(
                                          'Reset link sent to your registered email',
                                        );
                                        resetPasswordController.clear();
                                        Navigator.pop(context);
                                      }).onError((error, stackTrace) {
                                        Utils.toastMessage(error.toString());
                                      });
                                    }
                                  }
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style:
                              Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginController(),
                      child: Consumer<LoginController>(
                        builder: (context, provider, child) {
                          return RoundButton(
                            title: 'Login',
                            isLoading: provider.loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.login(
                                    context,
                                    emailController.text.toString(),
                                    passwordController.text.toString());
                              }
                            },
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        Navigator.pushNamed(context, RouteName.signUpScreen);
                      },
                      child: Text.rich(
                        TextSpan(
                            text: 'Don\'t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 17),
                            children: [
                              TextSpan(
                                text: ' SignUp',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.primaryMaterialColor,
                                    ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
