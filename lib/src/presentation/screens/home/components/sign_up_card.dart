import 'package:home_storage/src/domain/user/entities/user_app.dart';
import 'package:home_storage/src/presentation/utils/field_validator.dart';
import 'package:flutter/material.dart';

class SignUpCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(UserApp) onConfirm;

  const SignUpCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onConfirm,
  });

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
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
                controller: widget.nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: widget.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                validator: (value) => FieldValidators().emailValidate(value),
              ),
              TextFormField(
                controller: widget.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                obscureText: true,
                validator: (value) => FieldValidators().passwordValidate(value),
              ),
              FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    UserApp userApp = UserApp(
                      name: widget.nameController.text,
                      email: widget.emailController.text,
                    );
                    widget.onConfirm(userApp);
                  }
                },
                child: const Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
