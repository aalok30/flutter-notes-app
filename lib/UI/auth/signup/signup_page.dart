import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/app_textfiled.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20.r),
          child: Column(
            children: [
              40.verticalSpace,
              const Text('Welcome to NotApp!', style: TextStyle(fontSize: 20)),
              40.verticalSpace,
              buildSignUpForm(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: AppButton(
                  title: "Sign Up",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Signup pressed");
                    }
                  },
                ),
              ),
              10.verticalSpace,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account ? ",
                      style: TextStyle(
                        fontSize: 15.spMin,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(LoginRoute());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            hintText: "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }

              final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

              if (!regex.hasMatch(value)) {
                return "Enter a valid email";
              }

              return null;
            },
          ),
          20.verticalSpace,
          AppTextField(
            hintText: "Password",
            controller: passwordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be 6 characters";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
