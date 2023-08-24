import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/text_form_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';
import '../../res/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    passwordController.dispose();
    userNameController.dispose();
    userNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image:
                            const AssetImage('assets/images/chat_app_icon.png'),
                        height: height * .1,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Welcome to MASS NOVA',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Colors.lightBlue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 32,
                                ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Create account to continue!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 22,
                            ),
                      ),
                      SizedBox(
                        height: height * .1,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // TextFormFieldComponent(hintText: 'Testing', controller: emailController, focusNode: emailFocusNode, validator: (value){}, onFieldSubmitted: (ne){}, keyboardType: TextInputType.text, icon: Icons.add),
                            TextFormFieldComponent(
                              hintText: 'Enter your username',
                              controller: userNameController,
                              focusNode: userNameFocusNode,
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Enter your username'
                                    : null;
                              },
                              onFieldSubmitted: (newValue) {
                                Utils.fieldFocus(
                                    context, userNameFocusNode, phoneNumberFocusNode);
                              },
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.account_box,
                            ),
                            TextFormFieldComponent(
                              hintText: 'Enter your phone number',
                              controller: phoneNumberController,
                              focusNode: phoneNumberFocusNode,
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Enter your phone Number'
                                    : null;
                              },
                              onFieldSubmitted: (newValue) {
                                Utils.fieldFocus(
                                    context, phoneNumberFocusNode, emailFocusNode);
                              },
                              keyboardType: TextInputType.phone,
                              icon: Icons.phone,
                            ),
                            TextFormFieldComponent(
                              hintText: 'Enter your email',
                              controller: emailController,
                              focusNode: emailFocusNode,
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Enter your email'
                                    : null;
                              },
                              onFieldSubmitted: (newValue) {
                                Utils.fieldFocus(
                                    context, emailFocusNode, passwordFocusNode);
                              },
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.email,
                            ),
                            TextFormFieldComponent(
                              hintText: 'Enter your password',
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              obscureText: true,
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Enter your password'
                                    : null;
                              },
                              onFieldSubmitted: (newValue) {
                                Utils.fieldFocus(context, passwordFocusNode, null);
                              },
                              keyboardType: TextInputType.text,
                              icon: Icons.password,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      RoundButton(
                        title: 'SignUp',
                        isLoading: provider.loading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.singup(
                              context,
                              userNameController.text.toString(),
                              emailController.text.toString(),
                              passwordController.text.toString(),
                              phoneNumberController.text.toString(),
                            );
                          }
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 17),
                            children: [
                              TextSpan(
                                text: ' Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.primaryMaterialColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }
}
