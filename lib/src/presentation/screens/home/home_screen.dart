import 'package:home_storage/src/domain/user/entities/auth_params.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_bloc.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_event.dart';
import 'package:home_storage/src/presentation/screens/access/bloc/access_state.dart';
import 'package:home_storage/src/presentation/screens/home/components/login_card.dart';
import 'package:home_storage/src/presentation/screens/home/components/sign_up_card.dart';
import 'package:home_storage/src/presentation/utils/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AccessBloc bloc = BlocProvider.of<AccessBloc>(context);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                login = !login;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(login ? 'Sign Up' : 'Login'),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AccessBloc, AccessState>(
        listener: (context, state) {
          if (state is AccessErrorState) {
            setState(() {
              errorMessage = state.message;
            });
          }
        },
        builder: (context, state) {
          if (state is AccessLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (login)
                    LoginCard(
                        emailController: emailController,
                        passwordController: passwordController,
                        onConfirm: () {
                          AuthParams authParams = AuthParams(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          bloc.add(LoginAccessEvent(authParams: authParams));
                        },
                        onForgotPassword: () {
                          if (FieldValidators().emailValidate(emailController.text) == null) {
                            bloc.add(ForgotPasswordAccessEvent(email: emailController.text));
                          }
                        }),
                  if (!login)
                    SignUpCard(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      onConfirm: (user) {
                        AuthParams authParams = AuthParams(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        bloc.add(SignUpAccessEvent(authParams: authParams, user: user));
                      },
                    ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => bloc.add(LoginWithGoogleAccessEvent()),
                    child: const Text('Google Sign In'),
                  ),
                  const SizedBox(height: 16),
                  if (state is AccessLoadedState)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Text('User: ${state.user?.name ?? 'No user'}'),
                            const SizedBox(height: 8),
                            Text('Bloc state: ${state.runtimeType}'),
                            const SizedBox(height: 8),
                            if (state.user != null)
                              FilledButton(
                                onPressed: () => bloc.add(LogoutAccessEvent()),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Logout'),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
