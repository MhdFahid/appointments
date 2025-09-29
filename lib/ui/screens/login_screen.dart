import 'package:appointments/ui/widgets/custom_button.dart';
import 'package:appointments/ui/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'test_user');
  final _passwordController = TextEditingController(text: '12345678');

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.login(
          _usernameController.text,
          _passwordController.text,
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/login_logo.png'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text('Login Or Register To Book Your Appointments',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    SizedBox(height: size.height * 0.05),
                    CustomTextField(
                      controller: _usernameController,
                      labelText: "Username",
                      field: 'Username',
                    ),
                    SizedBox(height: size.height * 0.05),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      field: 'Password',
                    ),
                    SizedBox(height: size.height * 0.05),
                    CustomButton(
                      onPressed: _login,
                      buttonText: 'Login',
                      isLoading:
                          Provider.of<AuthProvider>(context).authIsLoading,
                    ),
                    SizedBox(height: size.height * 0.05),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:
                                "By creating or logging into an account you are agreeing with our ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            children: [
                              TextSpan(
                                text: "Terms and Conditions",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Terms page
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Terms and Conditions tapped")),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: " and ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Privacy page
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Privacy Policy tapped")),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: ".",
                                style: TextStyle(color: Colors.black),
                              ),
                            ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
