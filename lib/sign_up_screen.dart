import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_batch40/views/auth_module/log_in.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up Account',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
            SizedBox(height: 20,),
            TextFormField(
              controller : emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text('Email'),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text('Password'),
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                setState(() {
                  isLoading = true;
                });
                try{

                  // sign up
                  UserCredential userId = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Account Created Sucessfull!')));

                  print('User id -------->${userId.user!.uid}');
                  setState(() {
                    isLoading = false;
                  });

                }catch(e){
                  print('Sign up error ------------>$e');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Account Created Issue')));
                  setState(() {
                    isLoading = false;
                  });
                }finally{
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text('Sign up',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: RichText(text: TextSpan(
                  children: [
                    TextSpan(text: "Do you have already account ? ",style: TextStyle(color: Colors.black87)),
                    TextSpan(text: "Login",style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold))
                  ]
              )),
            ),
          ],
        ),
      ),
    );
  }
}
