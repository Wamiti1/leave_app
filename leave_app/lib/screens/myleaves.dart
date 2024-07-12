import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leave_app/repetitive/apiurl.dart';
import 'package:http/http.dart' as http;
import 'package:leave_app/screens/oneleave.dart';


class LeaveApplications extends StatefulWidget {
  const LeaveApplications({super.key});

  @override
  State<LeaveApplications> createState() => _LeaveApplicationsState();
}

class _LeaveApplicationsState extends State<LeaveApplications> {
List<dynamic> getApplications  () {
  //createdAt,id,leave_type,serial_number,updatedAt
  return applications;

} 
List applications =[];
Map<String, dynamic> oneleave ={};
@override
  void initState() {
    super.initState();
    getLeaves();
  }



Future getLeaves()async{

  http.Response response = await http.get(Uri.parse('$apionline/leave-apps'));

  if (response.statusCode == 200){
    if(mounted){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: const Text('Refreshed successfully'),
      width: MediaQuery.of(context).size.width*0.7,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      ));}
    setState((){
      applications = json.decode(response.body);
    });
  }
  else{
    if(mounted){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));}
   
  }
}

 Future deleteLeave(int id) async {
    http.Response response =
        await http.delete(Uri.parse('$apionline/leave-apps/$id'));
    if (response.statusCode == 200) {
      getLeaves();
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully deleted')));}
    } else {
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to delete')));}
    }
    
  }

  Future getoneLeave(int id) async{
    http.Response response = await http.get(Uri.parse('$apionline/leave-apps/$id'));
    if(response.statusCode == 200){
      if(mounted){
        setState(() {
        oneleave = jsonDecode(response.body);
                
      });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully retrieved')));
      }
      
    }
    else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body).toString())));
      }

    }
 

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){getLeaves();}, icon: const Icon(Icons.refresh))],
        title: const Center(child: Text("Leave Applications")),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: 
           List.generate(applications.length, (index){
            return ListTile(
              leading: CircleAvatar(child: Text(applications[index]['user_id'].toString()),),
              title:  Text(applications[index]['leave_type'].toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(applications[index]['serial_number'].toString()),
                    Text(applications[index]['createdAt'].toString()), 
                  ],     
              ),
              trailing:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filled(onPressed: (){
                  getoneLeave(applications[index]['id']);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyWidget(oneleave: oneleave)));

                  }, icon: const Icon(Icons.edit)),
                  IconButton.filled(onPressed: (){
                    
                   deleteLeave(applications[index]['id']); 
                  }, icon: const Icon(Icons.delete_forever)),
                ],
              ),
            );
           })
            
          ,),
      ),



    );


  }





}