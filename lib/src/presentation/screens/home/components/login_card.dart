import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onConfirm;
  final VoidCallback onForgotPassword;

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onConfirm,
    required this.onForgotPassword,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: widget.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              TextFormField(
                controller: widget.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                obscureText: true,
              ),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onConfirm();
                  }
                },
                child: const Text('Enter'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: widget.onForgotPassword,
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
