import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/presentation/bloc/login/login_form/login_form_bloc.dart';

import 'widgets/login_header.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight =
        (MediaQuery.of(context).size.height) - kToolbarHeight * 2;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 30, 46),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: LoginHeader(
                  heading: 'Register',
                  subHeading: 'Sign up to your Account',
                ),
              ),
              Flexible(
                flex: 3,
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kBigPadding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  onTapOutside: (event) => nameFocusNode.unfocus(),
                  onFieldSubmitted: (value) {
                    nameFocusNode.unfocus();
                    emailFocusNode.requestFocus();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Max Mustermann',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    label: Text("Full Name"),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: kBigPadding),
                TextFormField(
                  controller: emailController,
                  //validator: context.read<LoginFormBloc>().validateEmail,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  onTapOutside: (event) => emailFocusNode.unfocus(),
                  onFieldSubmitted: (value) {
                    emailFocusNode.unfocus();
                    passwordFocusNode.requestFocus();
                  },
                  decoration: const InputDecoration(
                    hintText: 'test@email.com',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: kBigPadding),
                TextFormField(
                  controller: passwordController,
                  //validator: context.read<LoginFormBloc>().validatePassword,
                  obscureText: true,
                  focusNode: passwordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  onTapOutside: (event) => passwordFocusNode.unfocus(),
                  onFieldSubmitted: (value) {
                    passwordFocusNode.unfocus();
                    confirmPasswordFocusNode.requestFocus();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: kBigPadding),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  //validator: context.read<LoginFormBloc>().validateEmail,
                  focusNode: confirmPasswordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  onTapOutside: (event) => confirmPasswordFocusNode.unfocus(),
                  onFieldSubmitted: (value) {
                    confirmPasswordFocusNode.unfocus();
                  },
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    label: Text("Confirm Password"),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
