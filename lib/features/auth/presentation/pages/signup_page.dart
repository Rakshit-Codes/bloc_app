import 'package:bloc_app/core/common/widgets/loader.dart';
import 'package:bloc_app/core/constant/app_string.dart';
import 'package:bloc_app/core/utils/show_snackbar.dart';
import 'package:bloc_app/core/utils/theme/app_pallete.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          showSnackBar(context, state.message);
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
                                AppString.signup,
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30),
                              AuthField(
                                hintText: AppString.name,
                                controller: nameController,
                              ),
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
                                text: AppString.buttonsignup,
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      AuthSignUp(
                                        name: nameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, LoginPage.route());
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: AppString.already_have_an_account,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    children: [
                                      TextSpan(
                                        text: AppString.signin,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
