
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudOperationsScreen extends StatefulWidget {
  const CrudOperationsScreen({super.key});

  @override
  State<CrudOperationsScreen> createState() => _CrudOperationsScreenState();
}

class _CrudOperationsScreenState extends State<CrudOperationsScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // for update

  final  updateFirstName = TextEditingController();
  final  updateLastName = TextEditingController();
  bool isLoading = false;
  
  // Create
  
  Future<void> createData()async{
    setState(() {
      isLoading = true;
    });
    try{
      await FirebaseFirestore.instance.collection('crud_operations').add({
        'firstName' : firstNameController.text,
        'lastName' : lastNameController.text
      });
      print('Data added successfully!!');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.green,
          content: Text('Data added Successfully!!')));
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print('Data added issue ------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Data added Successfully!!')));
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
    return FirebaseFirestore.instance.collection('crud_operations').snapshots();
  }


  // update
  Future<void> updateData(String id)async{
    try{
      await FirebaseFirestore.instance.collection('crud_operations').doc(id).update({
        'firstName' : updateFirstName.text,
        'lastName' : updateLastName.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('updated added Successfully!!')));

    }catch(e){
      print('Upated data issue please check out ---------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('updated added issue')));
    }
  }


  // delete
  Future<void> deleteData(String id)async{
    try{
      await FirebaseFirestore.instance.collection('crud_operations').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Data deleted Successfully!!')));

    }catch(e){
      print('deleted data issue please check out ---------->$e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Date deleted issue')));
    }
  }







  // dialog

  Future<void> updateDialog(String id){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Update data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: updateFirstName,
              decoration: InputDecoration(
                label: Text('Update First name'),
                hintText: 'Enter update first name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: updateLastName,
              decoration: InputDecoration(
                  label: Text('Update Last name'),
                  hintText: 'Enter update last name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),
            ),
          ],
        ) ,
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('NO')),
          ElevatedButton(onPressed: (){
            updateData(id);
            Navigator.pop(context);
            updateFirstName.clear();
            updateLastName.clear();
          },
              child: Text('Save'))
        ],
      );
    });
  }


  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        title : Text('Crud operation',style: TextStyle(color: Colors.white),),
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
              onTap: (){
                createData();
                firstNameController.clear();
                lastNameController.clear();
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
                    return Center(child: Text('Something went wrong!!'));
                  }else if(!snapshot.hasData){
                    return Center(child: Text('Data not found'));
                  }else{
                    return Expanded(
                      child: ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            final data = snapshot.data!.docs[index];
                            return Card(
                              child: ListTile(
                                title: Text(data['firstName'].toString()),
                                subtitle: Text(data['lastName'].toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap : (){
                                   updateDialog(data.id);
                              },
                                        child: Icon(Icons.edit,color: Colors.blue,)),
                                    SizedBox(width: 20,),
                                    GestureDetector(
                                        onTap: (){
                                          deleteData(data.id);
                                        },
                                        child: Icon(Icons.delete_forever,color: Colors.red,))
                                  ],
                                ),
                              ),
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
