import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/lottie_loading.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/auth/cubit/register_cubit.dart';
import 'package:ecommerce_app/features/auth/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController fullnameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    fullnameController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpace(28),
                SizedBox(
                  width: 335.w,
                  child: Text(
                    'Create an account',
                    style: AppStyles.primaryHeadLinesStyle,
                  ),
                ),
                const HeightSpace(8),
                SizedBox(
                  width: 335.w,
                  child: Text(
                    'Let’s create your account.',
                    style: AppStyles.grey12MediumStyle,
                  ),
                ),
                const HeightSpace(32),
                Text('Full Name', style: AppStyles.black16w500Style),
                const HeightSpace(8),
                CustomTextField(
                  controller: fullnameController,
                  hintText: 'Enter Your Full Name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const HeightSpace(16),
                Text('User Name', style: AppStyles.black16w500Style),
                const HeightSpace(8),
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Enter Your User Name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.trim().length < 6) {
                      return 'Username must be at least 6 characters';
                    }
                    final englishRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
                    if (!englishRegex.hasMatch(value.trim())) {
                      return 'Only English letters, numbers, _ and - are allowed';
                    }
                    return null;
                  },
                ),
                const HeightSpace(16),
                Text('Email', style: AppStyles.black16w500Style),
                const HeightSpace(8),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter Your Email',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                ),
                const HeightSpace(16),
                Text('Password', style: AppStyles.black16w500Style),
                const HeightSpace(8),
                CustomTextField(
                  hintText: 'Enter Your Password',
                  controller: passwordController,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.greyColor,
                    size: 20.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const HeightSpace(16),
                Text('Confirm Password', style: AppStyles.black16w500Style),
                const HeightSpace(8),
                CustomTextField(
                  hintText: 'Re-enter Your Password',
                  controller: confirmPasswordController,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.greyColor,
                    size: 20.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const HeightSpace(40),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: ((context, state) {
                    if (state is RegisterErorrState) {
                      context.showAnimatedSnackBar(
                        message: state.errorMessage,
                        type: AnimatedSnackBarType.error,
                      );
                    }
                    if (state is RegisterSuccessState) {
                      log(state.response.id.toString());
                      context.showAnimatedSnackBar(
                        message: 'Account created successfully!',
                        type: AnimatedSnackBarType.success,
                      );
                      context.pushReplacementNamed(AppRoutes.loginScreen);
                    }
                  }),
                  builder: ((context, state) {
                    if (state is RegisterLoadState) {
                      return const Center(
                        child: LottieLoading(),
                      );
                    }
                    return PrimayButtonWidget(
                      buttonText: 'Create Account',
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().register(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text);
                        }
                      },
                    );
                  }),
                ),
                const HeightSpace(24),
                Center(
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Do you have an account? ',
                        style: AppStyles.black16w500Style
                            .copyWith(color: AppColors.secondaryColor),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: AppStyles.black15BoldStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
