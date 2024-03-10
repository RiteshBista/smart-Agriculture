import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartAgriculture/main.dart';
import 'package:smartAgriculture/utils/utils.dart';



class SignupPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignupPage({super.key, required this.onClickedSignIn});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
      backgroundColor: Colors.white,
      body: Container(
         width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
      image: DecorationImage(
        image:  const AssetImage('images/bg.jpeg'),        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
      ),),
        child: Column(
          children: [
            const SizedBox(height: 70),
            // Image(
            //   alignment: Alignment.center,
            //   height: 100.0,
            //   width: 100.0,
            //   image: AssetImage('lib/assets/images/logo.png'),
            // ),
            const SizedBox(height: 70),
            const Text(
              "Register",
              textAlign: TextAlign.center,
              
              style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold',
              color: Colors.white
              ),
            ),
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
                          color: Colors.grey,
                          fontSize: 10.0,
                        )),
                    style: const TextStyle(fontSize: 14,
                    color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        )),
                    style: const TextStyle(fontSize: 14,
                    color: Colors.white,
                    
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: signUp,
                    child: const Text('Signup',
                   style: TextStyle(

                    color: Colors.white,
                   )
              
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
                      color: Colors.black,
                    ),
                    text: 'Don\'t have an account?',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Log In',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ))
                ])),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator()
          ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
    } on FirebaseException catch (error) {
      Utils.showSnackBar(error.message);
    }
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}