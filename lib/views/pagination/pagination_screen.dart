

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {

  int startPoint = 0;
  int endPoint = 10;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  bool hasMore = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();

    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent && !isLoading  && hasMore){
        getApi();
      }
    });
  }


  List<dynamic> localList = [];

  // pagination api
  Future<void> getApi()async{
    setState(() {
      isLoading = true;
    });
    try{
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=$startPoint&_limit=$endPoint');
      final response = await http.get(url);
      if(response.statusCode == 200){
        print('Response --------->$response');

        List<dynamic> data = jsonDecode(response.body.toString());
        print('data --------->$data');

        setState(() {
          startPoint += endPoint;
          localList.addAll(data);
          isLoading = false;
          if(data.length < endPoint){
            hasMore = false;
          }

        });
      }

    }catch(e){
      print('error ------>$e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination'),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: localList.length + (hasMore ? 1 : 0),
        controller: scrollController,
          itemBuilder: (context,index){
          if(index < localList.length){
            return ListTile(
              title: Text('Title : ${localList[index]['title']}'),
              subtitle: Text('Body :${localList[index]['body']} '),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }


      }),
    );
  }
}
