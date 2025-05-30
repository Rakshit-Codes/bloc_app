import 'package:bloc_app/core/common/widgets/loader.dart';
import 'package:bloc_app/core/constant/app_string.dart';
import 'package:bloc_app/core/utils/show_snackbar.dart';
import 'package:bloc_app/core/utils/theme/app_pallete.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/signup_page.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.all(15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                       if (state is AuthFailure) {
                          showSnackBar(context , state.message);
                        } else if ( state is AuthSuccess){
                          Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false,);
                        }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                          return const Loader();
                        }
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.signin,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(height: 15),
                            AuthField(
                              hintText: AppString.email,
                              controller: emailController,
                            ),
                            SizedBox(height: 15),
                            AuthField(
                              hintText: AppString.password,
                              controller: passwordController,
                              isObscureText: true,
                            ),
                            SizedBox(height: 20),
                            AuthGradientButton(
                              text: AppString.buttonsignin,
                              onpressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthLogin(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, SignupPage.route());
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: AppString.dont_have_an_account,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  children: [
                                    TextSpan(
                                      text: AppString.signup,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
