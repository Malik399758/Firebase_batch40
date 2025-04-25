import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_batch40/views/auth_module/log_in.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final currentUserId = FirebaseAuth.instance.currentUser;


  // Logout

  Future<void> logoutAccount()async{
    try{
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Logout Successfully!!')));
    }catch(e){
      print('Logout issue -------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Logout Issue please try again!!')));
    }
  }


  // delete

  Future<void> deleteAccount()async{
    try{
      await FirebaseAuth.instance.currentUser!.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Delete account Successfully!!')));

    }catch(e){
      print('Delete account issue ----->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Delete account issue please try again!!')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen',style: TextStyle(fontSize: 18,color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(currentUserId!.uid.isNotEmpty){
                      logoutAccount();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue
                    ),
                    child: Icon(Icons.logout,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap: ()async{
                    await deleteAccount();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue
                    ),
                    child: Icon(Icons.delete,color: Colors.white,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Logout account'),
                SizedBox(width: 50,),
                Text('Delete account'),

              ],
            )
           
          ],
        ),
      ),
    );
  }
}
