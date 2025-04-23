import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_batch40/sign_up_screen.dart';
import 'package:firebase_batch40/views/home_module/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Account',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
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
            // login
            GestureDetector(
              onTap: ()async{
                setState(() {
                  isLoading = true;
                });
                try{
                 UserCredential userId =  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                 if(userId.user!.uid.isNotEmpty){
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       backgroundColor: Colors.green,
                       content: Text('Logged in Sucuess!!')));
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                   print('User id ------->${userId.user!.uid}');
                   setState(() {
                     isLoading = false;
                   });
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       backgroundColor: Colors.red,
                       content: Text('User does not exists!!')));
                   setState(() {
                     isLoading = false;
                   });
                 }
                }catch(e){
                  setState(() {
                    isLoading = false;
                  });
                  print('Error --------->$e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Something went wrong')));
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
                child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: RichText(text: TextSpan(
                children: [
                  TextSpan(text: "Don't have an account ? ",style: TextStyle(color: Colors.black87)),
                  TextSpan(text: "Sign up",style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold))
                ]
              )),
            ),
          ],
        ),
      ),
    );
  }
}
