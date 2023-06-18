
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_button_widget.dart';
import '../../constants/typography.dart';
import '../../models/email_model.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _focusNode = FocusNode();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              _topLogoWidget(),
              const SizedBox(height: 40),
              _topTitleWidget(),
              const SizedBox(height: 40),
              _emailInputWidget(),
              const SizedBox(height: 20),
              _passwordInputWidget(),
              const SizedBox(height: 150),
              _loginButton(),
              const SizedBox(height: 20),
              _forgotPasswordTextWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return AppButtonWidget(
      buttonText: 'Login',
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
    );
  }

  Widget _forgotPasswordTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {},
            child: Text(
              'Forgot Password',
              style: bodyFont16Green,
            )),
      ],
    );
  }

  Widget _passwordInputWidget() {
    return Container(
      width: 340,
      height: 53,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF88DA09)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.text,
        style: bodyFont16Black,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: 'Password',
          hintStyle: bodyFont16Grey,
        ),
      ),
    );
  }

  Widget _emailInputWidget() {
    return Consumer<EmailModel>(
      builder: (context, emailModel, _) {
        return Container(
          width: 340,
          height: 53,
          decoration: BoxDecoration(
            border: emailModel.isEmailCorrect
                ? Border.all(color: const Color(0xFF88DA09))
                : Border.all(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            onChanged: (value) {
              emailModel.updateEmail(value);
            },
            focusNode: _focusNode,
            controller: emailController,
            keyboardType: TextInputType.text,
            style: bodyFont16Black,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Email',
              hintStyle: bodyFont16Grey,
            ),
          ),
        );
      },
    );
  }

  Widget _topLogoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/pngs/bit.png',
          height: 60,
          width: 60,
        ),
      ],
    );
  }

  Widget _topTitleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Log in',
          style: h2Bold,
        )
      ],
    );
  }
}
