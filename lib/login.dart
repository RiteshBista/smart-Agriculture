
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartAgriculture/main.dart';
import 'package:smartAgriculture/utils/utils.dart';



class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({super.key, required this.onClickedSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
         width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
      image: DecorationImage(
        image:const AssetImage('images/bg.jpeg'),
        
                fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
      ),),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                // Image(
                //   alignment: Alignment.center,
                //   height: 100.0,
                //   width: 100.0,
                //   image: AssetImage('lib/assets/images/logo.png'),
                // ),
               const SizedBox(height: 50,),
               const Text(
              'Smart Agriculture App ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Login ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
           const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                     
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            )),
                        style: const TextStyle(fontSize: 14,
                        color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value != null && value.length < 6
                                ? "Enter at least 6 characters"
                                : null,
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            )),
                        style: const TextStyle(fontSize: 14,
                               color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: signIn,
                        child: const Text('Login',
                        style: TextStyle(
color: Colors.white,

                        ),
                        ),
                      )
                      // FillButton(
                      //   title: 'Login',
                      //   color: BrandColors.colorGreen,
                      //   onPressed: () async {
                      //     // Check Network Availability
                      //     var connectivityResult =
                      //         await Connectivity().checkConnectivity();
        
                      //     if (connectivityResult != ConnectivityResult.mobile &&
                      //         connectivityResult != ConnectivityResult.wifi) {
                      //       showSnackBar("No Internet Connectivity.");
                      //       return;
                      //     }
        
                      //     if (passwordController.text.length < 8) {
                      //       showSnackBar("Please enter a valid password");
                      //       return;
                      //     }
        
                      //     login();
                      //   },
                      // ),
                    ],
                  ),
                ),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        text: 'Don\'t have an account?',
                        
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: 'Sign up',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ))
                    ])),
        
                ElevatedButton(
                  child: const Text('Forgot Password'),
                  onPressed: ()
                  {}
                  //  => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ForgotPasswordPage())),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
    } on FirebaseException catch (error) {
      Utils.showSnackBar(error.message);
    }
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}