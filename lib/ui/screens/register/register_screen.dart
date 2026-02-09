import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../firebase_utils/firestore_utility.dart';
import '../../model/user_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/constants.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/evently_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.appLogo),
                  const SizedBox(height: 48),
                  const Text(
                    "Create your account",
                    style: AppTextStyles.blue24SemiBold,
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    hint: "Enter your name",
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: nameController,
                    validator: (text) {
                      if (text?.isEmpty == true) return "Please enter a valid name";
                      return null;
                    },
                  ),
                  AppTextField(
                    hint: "Address",
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: addressController,
                    validator: (text) {
                      if (text?.isEmpty == true) return "Please enter a valid address";
                      return null;
                    },
                  ),
                  AppTextField(
                    hint: "phone number",
                    prefixIcon: SvgPicture.asset(AppAssets.icPersonSvg),
                    controller: phoneController,
                    validator: (text) {
                      if (text?.isEmpty == true || text!.length < 11) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: "Enter your email",
                    prefixIcon: SvgPicture.asset(AppAssets.icEmailSvg),
                    controller: emailController,
                    validator: (text) {
                       if (text == null || text.trim().isEmpty) {
                        return "Please enter a valid email";
                       }
                      final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!emailRegex.hasMatch(text)) {
                        return "The email is not in a valid format";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: "Enter your password",
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "Please enter valid password";
                      }
                      if (text.length < 6) {
                        return "Your password is weak";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hint: "Confirm your password",
                    suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                    prefixIcon: SvgPicture.asset(AppAssets.icLockSvg),
                    validator: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "Please enter valid password";
                      }
                      if (text != passwordController.text)
                        return "Password does not match";
                      return null;
                    },
                  ),
                  const SizedBox(height: 48),
                  buildRegisterButton(),
                  const SizedBox(height: 48),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?  ",
                          style: AppTextStyles.grey14Regular,
                        ),
                        Text(
                          "Login",
                          style: AppTextStyles.blue14SemiBold.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Or",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.blue14SemiBold,
                  ),
                  const SizedBox(height: 32),
                  buildGoogleSignInButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EventlyButton buildRegisterButton() => EventlyButton(
        text: "Register",
        onPress: () async {
          if (!formKey.currentState!.validate()) return;
          if (!mounted) return;
          showLoading(context);
          try {
            final credential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

            UserDM.currentUser = UserDM(
              id: credential.user!.uid,
              name: nameController.text,
              email: emailController.text,
              address: addressController.text,
              phoneNumber: phoneController.text,
            );

            await createUserInFirestore(UserDM.currentUser!); 
            if (!mounted) return;
            Navigator.pop(context);

            Navigator.pushReplacement(context, AppRoutes.navigation);
          } on FirebaseAuthException catch (e) {
            if (!mounted) return;
            Navigator.pop(context);
            var message = "";
            if (e.code == 'weak-password') {
              message = "The password provided is too weak.";
            } else if (e.code == 'email-already-in-use') {
              message = "The account already exists for that email.";
            } else {
              message = e.message ?? AppConstants.defaultErrorMessage;
            }
            showMessage(context, message, title: "Error", posText: "ok", posAction: () {  });
          } catch (e) {
            if (!mounted) return;
            Navigator.pop(context);
            showMessage(
              context,
              AppConstants.defaultErrorMessage,
              title: "Error",
              posText: "ok", posAction: () {  },
            );
          }
        },
      );

  EventlyButton buildGoogleSignInButton() {
    return EventlyButton(
      text: "Sign up with Google",
      onPress: () async {
        if (!mounted) return;
        showLoading(context);
        try {
          final userCredential = await signInWithGoogle();

          if (userCredential == null) {
            if (mounted) Navigator.pop(context); 
            return;
          }
          
          final user = userCredential.user;
          if (user != null) {
            final userFromDb = await getUserFromFirestore(user.uid);

            if (userFromDb != null) {
              UserDM.currentUser = userFromDb;
            } else {
              final newUser = UserDM(
                id: user.uid,
                name: user.displayName ?? nameController.text,
                email: user.email ?? emailController.text,
                address: addressController.text,
                phoneNumber: phoneController.text,
              );
              UserDM.currentUser = newUser;
              await createUserInFirestore(newUser);
            }
            if (!mounted) return;
            Navigator.pop(context);
            Navigator.pushReplacement(context, AppRoutes.navigation);
          }
        } catch (e) {
          if (!mounted) return;
          Navigator.pop(context);
          showMessage(context, AppConstants.defaultErrorMessage,
              title: "Error", posText: "ok", posAction: () {  });
        }
      },
      backgroundColor: AppColors.white,
      textStyle: AppTextStyles.blue18Medium,
      icon: SvgPicture.asset(AppAssets.icGmailSvg),
    );
  }

  Future signInWithGoogle() async {}
}
