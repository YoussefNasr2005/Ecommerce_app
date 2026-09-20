import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/lottie_loading.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit_.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(40),
                  SizedBox(
                    width: 335.w,
                    child: Text(
                      'Login To Your Account',
                      style: AppStyles.primaryHeadLinesStyle,
                    ),
                  ),
                  const HeightSpace(8),
                  SizedBox(
                    width: 335.w,
                    child: Text(
                      "It's great to see you again!",
                      style: AppStyles.grey12MediumStyle,
                    ),
                  ),
                  const HeightSpace(32),
                  Text('User Name', style: AppStyles.black16w500Style),
                  const HeightSpace(8),
                  CustomTextField(
                    controller: username,
                    hintText: 'Enter Your User Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const HeightSpace(16),
                  Text('Password', style: AppStyles.black16w500Style),
                  const HeightSpace(8),
                  CustomTextField(
                    hintText: 'Enter Your Password',
                    controller: password,
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: AppColors.greyColor,
                      size: 20.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 4) {
                        return 'Password must be at least 4 characters';
                      }
                      return null;
                    },
                  ),
                  const HeightSpace(40),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        context.showAnimatedSnackBar(
                          message: state.errorMessage,
                          type: AnimatedSnackBarType.error,
                        );
                      }
                      if (state is AuthSuccessState) {
                        context.showAnimatedSnackBar(
                          message: state.successMessage,
                          type: AnimatedSnackBarType.success,
                        );
                        context.goNamed(AppRoutes.splashScreen);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoginState) {
                        return SizedBox(
                          height: 50.h,
                          child: const Center(child: LottieLoading()),
                        );
                      }
                      return PrimayButtonWidget(
                        buttonText: 'Sign in',
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                  username: username.text.trim(),
                                  password: password.text,
                                );
                          }
                        },
                      );
                    },
                  ),
                  const HeightSpace(50),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.registerScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: AppStyles.black16w500Style
                              .copyWith(color: AppColors.secondaryColor),
                          children: [
                            TextSpan(
                              text: 'Join',
                              style: AppStyles.black15BoldStyle,
                            ),
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
      ),
    );
  }
}
