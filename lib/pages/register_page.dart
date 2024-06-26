import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cfpasswordController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async{
    final authService = AuthService();

    if(_passwordController.text == _cfpasswordController.text){
      try{
        await authService.signUpWithEmailPassword(_emailController.text, _passwordController.text, _unameController.text);
      }

      catch(e){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
        );
      }
    } else {
      showDialog(context: context, builder: (context) => AlertDialog(
          title: Text("Passwords do not Match !!")
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Create a New Account for You !!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: 'Email',
              pass: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 12,
            ),
            MyTextfield(
              hintText: 'Username',
              pass: false,
              controller: _unameController,
            ),
            const SizedBox(
              height: 12,
            ),
            MyTextfield(
              hintText: 'Password',
              pass: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 12,
            ),
            MyTextfield(
              hintText: 'Confirm Password',
              pass: true,
              controller: _cfpasswordController,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an Account ? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Login Now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
