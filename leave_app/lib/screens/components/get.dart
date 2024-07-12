import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leave_app/repetitive/apiurl.dart';
import 'package:http/http.dart' as http;




class Get extends StatefulWidget {
  const Get({super.key});

  @override
  State<Get> createState() => _GetState();

  
}

class _GetState extends State<Get> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  final formKey = GlobalKey<FormState>();
  List users =[];

  Future getUsers()async{

  http.Response response = await http.get(Uri.parse('$apionline/users'));

  if (response.statusCode == 200){
    if(mounted){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: const Text('Refreshed successfully'),
      width: MediaQuery.of(context).size.width*0.7,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      ));}
    setState((){
      users = json.decode(response.body);
    });
  }
  else{
    if(mounted){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));}
   
  }
}  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Get Users', style: TextStyle(fontSize: 25),
        
        ), 
        actions: [IconButton(onPressed: (){
        getUsers();
        },icon: const Icon(Icons.refresh))],
        
        ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: users.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(users[index]['firstname']),
            subtitle: Text(users[index]['email']),
          );
        })


    );
  }
}