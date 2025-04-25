

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController  = TextEditingController();
  final passwordController  = TextEditingController();
  bool isLoading = false;
  
  
  // FireStore cloud data storage
  
  Future<void> uploadData(String userId)async{
    try{
      await FirebaseFirestore.instance.collection('batch40_data').doc(userId).set({
        'FirstName' : firstNameController.text,
        'LastName' : lastNameController.text,
        'Email' : emailController.text,
        'Password' : passwordController.text
      });
    } catch(e){
      print('Upload data issue !! -------->$e');
    }
  }

  Future<void> delete()async{
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign out')));
  }

  Future<void> delete1()async{
    User? user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('delete out')));
    }else{
      print('User not exists');
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Register',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
            SizedBox(height: 20,),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                label: Text('First name'),
                hintText: 'Enter first name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                  label: Text('Last name'),
                  hintText: 'Enter last name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  label: Text('Email'),
                  hintText: 'Enter email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  label: Text('Password'),
                  hintText: 'Enter password',
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
                  UserCredential userId = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text, 
                      password: passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Register successfully!!')));

                  print('User id ---------->${userId.user!.uid}');

                  await uploadData(userId.user!.uid);
                  
                  setState(() {
                    isLoading = false;
                  });
                  
                }catch(e){
                  print('error --------->$e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Something went wrong!!')));
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
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue
                ),
                child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

