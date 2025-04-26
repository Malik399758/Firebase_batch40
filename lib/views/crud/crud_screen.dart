
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool isLoading = false;


  // Create

  Future<void> addData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await FirebaseFirestore.instance.collection('batch').add({
        'firstName' : firstNameController.text,
        'lastName' : lastNameController.text,
      });
      print('Data added successfully!');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.green,
          content: Text('Data added successfully!!')));
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print('Data added error----------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Data added issue please check it')));
      setState(() {
        isLoading = false;
      });
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }



  // Read
  Stream<QuerySnapshot> readData(){
    return FirebaseFirestore.instance.collection('batch').snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text('Crud operation'),
        backgroundColor : Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
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
            SizedBox(height: 20,),
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
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                await addData();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,)) :
                Center(child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
              ),
            ),
            SizedBox(height: 10,),
            Divider(),

            StreamBuilder(
                stream: readData(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }else if(snapshot.hasError){
                    return Center(child: Text('Something went wrong'));
                  }else if(!snapshot.hasData){
                    return Center(child: Text('Data not found'));
                  }else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                        final data = snapshot.data!.docs[index];
                        return ListTile(
                          title:Text(data['firstName'].toString()) ,
                          subtitle: Text(data['lastName'].toString()),
                        );
                      }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
