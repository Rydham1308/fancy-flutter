import 'package:fancy/constants/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

import '../../models/user_model.dart';
import 'firebase_auth_bloc/firebase_auth_bloc.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isCheck = false;
  bool isObscureTextPass = true;
  ValueNotifier<bool> isRegistered = ValueNotifier(true);

  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirebaseAuthBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              // bg and partitions
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 12,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.brown.shade200.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //text
              Container(
                margin: const EdgeInsets.only(top: 125, left: 25),
                child: const Text(
                  'Create \nyour account',
                  style: TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),

              //Text Areas
              Container(
                margin: const EdgeInsets.only(top: 250, left: 25),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // name
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 55),
                        child: TextFormField(
                          controller: nameText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'name',
                            labelStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      //email
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 55),
                        child: TextFormField(
                          controller: emailText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else if (emailText.text.isValidEmail == false) {
                              return "Email is not valid";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // password
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 55),
                        child: TextFormField(
                          controller: passText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else if (passText.text.isValidPassword == false) {
                              return "Password should include at-least one Capital, Small, Number & Spacial Char.";
                            } else if (value.length < 6) {
                              return "Password should be at-least 6 characters";
                            } else if (value.length > 15) {
                              return "Password should not be greater than 15 characters";
                            } else {
                              return null;
                            }
                          },
                          obscureText: isObscureTextPass,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: isObscureTextPass
                                ? IconButton(
                                    color:
                                        const Color.fromARGB(255, 73, 73, 73),
                                    onPressed: () {
                                      setState(() {
                                        isObscureTextPass = false;
                                      });
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.eye_slash,
                                      color: Colors.white,
                                    ),
                                  )
                                : IconButton(
                                    color:
                                        const Color.fromARGB(255, 73, 73, 73),
                                    onPressed: () {
                                      setState(() {
                                        isObscureTextPass = true;
                                      });
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.eye,
                                      color: Colors.white,
                                    ),
                                  ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.white54,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // buttons
              Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 560, bottom: 15, right: 35),
                      child: BlocConsumer<FirebaseAuthBloc, FirebaseAuthState>(
                        listener: (context, state) {
                          if (state is FirebaseAuthSuccess) {
                            Future.delayed(Duration.zero).then((value) =>
                                Navigator.pushNamed(context, '/home'));
                            Future.delayed(Duration.zero).then((value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Color(0xd52d2d2d),
                                    content: Text(
                                      "User Registered!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    duration: Duration(milliseconds: 1000),
                                  ),
                                ));
                          } else if (state is FirebaseAuthFailed) {
                            Future.delayed(Duration.zero).then((value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xd52d2d2d),
                                    content: Text(
                                      state.error,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                  ),
                                ));
                          } else if (state is FirebaseAuthLoading) {
                            isRegistered.value = false;
                          } else if (state is FirebaseAuthLoaded) {
                            isRegistered.value = true;
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // foregroundColor: Colors.white70,
                              // animationDuration: const Duration(milliseconds: 1000),
                              backgroundColor: Colors.white,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: const Size(290, 50),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                userModel.email = emailText.text.trim();
                                userModel.pass = passText.text.trim();
                                context.read<FirebaseAuthBloc>().add(
                                    UserRegister(json: userModel.toJson()));
                                // try {
                                //   isRegistered.value = false;
                                //   // await signUp();
                                //   await FireBaseAuthServices.signUpWithEmailPass(
                                //     emailText.text.trim(),
                                //     passText.text.trim(),
                                //   );
                                //   isRegistered.value = true;
                                //   Future.delayed(Duration.zero).then((value) =>
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //           backgroundColor: Color(0xd52d2d2d),
                                //           content: Text(
                                //             "User Registered!",
                                //             style: TextStyle(color: Colors.white),
                                //           ),
                                //           duration: Duration(milliseconds: 1000),
                                //         ),
                                //       ));
                                //   Future.delayed(Duration.zero)
                                //       .then((value) => Navigator.pop(context));
                                // } on FirebaseException catch (e) {
                                //   isRegistered.value = true;
                                //   Future.delayed(Duration.zero).then((value) =>
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(
                                //           backgroundColor: const Color(0xd52d2d2d),
                                //           content: Text(
                                //             e.message ?? '',
                                //             // (e as dynamic).message.toString(),
                                //             style:
                                //                 const TextStyle(color: Colors.white),
                                //           ),
                                //           duration:
                                //               const Duration(milliseconds: 1000),
                                //         ),
                                //       ));
                                // }
                              }
                            },
                            child: ValueListenableBuilder(
                              valueListenable: isRegistered,
                              builder: (context, value, child) {
                                return isRegistered.value
                                    ? const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 35),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          animationDuration: const Duration(milliseconds: 1000),
                          backgroundColor: Colors.grey.shade900,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(290, 50),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const WelcomeScreen(),
                          //   ),
                          // );
                          // Navigator.pushReplacement(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder: (context, animation1, animation2) => const WelcomeScreen(),
                          //     transitionDuration: const Duration(seconds: 0),
                          //   ),
                          // );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/images/google_icon.svg',
                                width: 15),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              '  Continue with Google',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Log in text
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 710, left: 35),
                    child: const Text(
                      'Already have account ?',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 710),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
