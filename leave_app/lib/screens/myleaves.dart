import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leave_app/repetitive/apiurl.dart';
import 'package:http/http.dart' as http;


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

Future getLeaves()async{

  http.Response response = await http.get(Uri.parse('$apionline/leave-apps'));

  if (response.statusCode == 200){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successful')));
    setState((){
      applications = json.decode(response.body);
    });
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
    print(response.body);
  }
}

Future deleteLeaves() async{


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
              trailing: const Row(children: [Icon(Icons.delete)],),
            );
           })
            
          ,),
      ),



    );


  }





}