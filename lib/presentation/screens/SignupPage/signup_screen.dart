import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utiles/validator.dart';
import 'package:project2/presentation/controller/authcubit/auth_cubit.dart';
import 'package:project2/presentation/controller/authcubit/auth_state.dart';
import 'package:project2/presentation/screens/HomePage/Home_Screen.dart';
import 'package:project2/presentation/screens/LoginPage/login_screen.dart';
import 'package:project2/presentation/screens/LoginPage/responsive_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double horizontalPadding = ResponsiveWidget.isSmallScreen(context)
        ? height * 0.052
        : height * 0.12;
    double inputFieldHeight = 50.0;

    return Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            width: width,
            child: Form(
              key: _formKey,
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("already exist")),
                  );
                }
              }, builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
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
                            text: ' Sign Up!',
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
                      'Hey, Enter your details to create \nyour account.',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: height * 0.064),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
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
                      height: inputFieldHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        validator: validateName, // Validation function
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple,
                          fontSize: 12.0,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.only(top: 16.0),
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.014),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      height: inputFieldHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        validator: validateEmail, // Validation function
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple,
                          fontSize: 12.0,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.deepPurple,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.only(top: 16.0),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.deepPurple,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.014),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
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
                      height: inputFieldHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: validatePassword, // Validation function
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple,
                          fontSize: 12.0,
                        ),
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Colors.deepPurple,
                          ),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Have an account?',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final name = _nameController.text;
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            context
                                .read<AuthCubit>()
                                .signup(name, email, password);
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
                            'Sign Up',
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
                );
              }),
            ),
          ),
        ));
  }
}
