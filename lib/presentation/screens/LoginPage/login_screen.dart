import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utiles/validator.dart';
import 'package:project2/presentation/controller/authcubit/auth_cubit.dart';
import 'package:project2/presentation/controller/authcubit/auth_state.dart';
import 'package:project2/presentation/screens/LoginPage/responsive_widget.dart';
import 'package:project2/presentation/screens/HomePage/Home_Screen.dart';

import '../SignupPage/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    _nameController.text = "ana";
    _passwordController.text = "12345678";
    return Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login failed: Unauthorized '),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveWidget.isSmallScreen(context)
                      ? height * 0.05
                      : height * 0.12),
              width: width,
              child: Form(
                // Wrap the entire form with a single Form widget
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.2),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Let’s',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 25.0,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign In!',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 25.0,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'Hey, Enter your details to sign in \nto your account.',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: height * 0.064),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        validator: validateName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple,
                          fontSize: 12.0,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),

                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.red, width: 2.0),
                          // ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple.withOpacity(1),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.014),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: validatePassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple,
                          fontSize: 12.0,
                        ),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Colors.deepPurple,
                          ),
                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.red, width: 2.0),
                          // ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          contentPadding: const EdgeInsets.only(top: 16.0),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final name = _nameController.text;
                            final password = _passwordController.text;
                            context
                                .read<AuthCubit>()
                                .login(name, password, context);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => MyHomePage(),
                            //   ),
                            // );
                          }
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.deepPurple,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xffFFFFFF),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
