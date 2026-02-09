import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../firebase_utils/firestore_utility.dart';
import '../../../l10n/app_localizations.dart';
import '../../model/user_dm.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/constants.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/evently_button.dart';

Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleUser =
  await googleSignIn.signIn();
  if (googleUser == null) {
    return null;
  }
  final GoogleSignInAuthentication googleAuth =
  await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance
      .signInWithCredential(credential);
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.appLogo),
              SizedBox(height: 48),
              Text(
                localization.loginHeaderMessage,
                style: AppTextStyles.blue24SemiBold,
              ),
              SizedBox(height: 24),
              AppTextField(
                controller: emailController,
                hint: localization.emailHint,
                prefixIcon: SvgPicture.asset(AppAssets.icEmailSvg), isPassword : false, minLines: 4,
              ),
              SizedBox(height: 16),
              AppTextField(
                controller: passwordController,
                hint: localization.passwordHint,
                suffixIcon: SvgPicture.asset(AppAssets.icEyeClosedSvg),
                prefixIcon: SvgPicture.asset(AppAssets.icLockSvg), isPassword : false, minLines: 4,
              ),
              SizedBox(height: 8),
              Text(
                localization.forgetPassword,
                textAlign: TextAlign.end,
                style: AppTextStyles.blue14SemiBold.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 48),
              buildLoginButton(),
              SizedBox(height: 48),
              InkWell(
                onTap: () {
                  Navigator.push(context, AppRoutes.register);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localization.dontHaveAccount,
                      style: AppTextStyles.grey14Regular,
                    ),
                    Text(
                      localization.signUp,
                      style: AppTextStyles.blue14SemiBold.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Text(
                localization.or,
                textAlign: TextAlign.center,
                style: AppTextStyles.blue14SemiBold,
              ),
              SizedBox(height: 32),
              EventlyButton(
                text: localization.googleLogin,
                onPress: () async {
                  // signInWithGoogle();
                  showLoading(context);
                  var user = await signInWithGoogle();
                  Navigator.pop(context);
                  if (user != null) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      AppRoutes.navigation,
                          (route) => false,
                    );
                  }

                },
                backgroundColor: AppColors.white,
                icon: Icon(Icons.g_mobiledata),
              ),
            ],
          ),
        ),
      ),
    );
  }


  EventlyButton buildLoginButton() => EventlyButton(
        text: AppLocalizations.of(context)!.login,
        onPress: () async {
          try {
            showLoading(context);
            final credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: emailController.text, //access text inside textfield
              password: passwordController.text,
            );

            UserDM.currentUser = await getUserFromFirestore(credential.user!.uid);
            if (!mounted) return;
            Navigator.pop(context);

            ///Hide loading
            if (!mounted) return;
            Navigator.push(context, AppRoutes.navigation);
          } on FirebaseAuthException catch (e) {
            if (!mounted) return;
            Navigator.pop(context);
            var message = "";
            if (e.code == 'user-not-found') {
              message = 'No user found for that email.';
            } else if (e.code == 'wrong-password') {
              message = 'Wrong password provided for that user.';
            } else {
              message = e.message ?? AppConstants.defaultErrorMessage;
            }
            if (!mounted) return;
            showMessage(context, message, title: "Error", posText: "ok", posAction: () {  });
          } catch (e) {
            if (!mounted) return;
            showMessage(
              context,
              AppConstants.defaultErrorMessage,
              title: "Error",
              posText: "ok", posAction: () {  },
            );
          }
        },
      );
  EventlyButton buildLoginButtonWithGoogle() => EventlyButton(
    text: AppLocalizations.of(context)!.login,
    onPress: () async {
      try {
        showLoading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserDM.currentUser = await getUserFromFirestore(credential.user!.uid);
        Navigator.pop(context); // hide loading
        Navigator.push(context, AppRoutes.navigation);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // hide loading
        var message = e.message ?? "Something went wrong please try wrong";
        showMessage(context, message, title: "Error", posText: "ok", posAction: () {  });
      } catch (e) {
        print(e);
      }
    },
  );

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}




