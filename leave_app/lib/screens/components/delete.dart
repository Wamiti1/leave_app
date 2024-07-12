import 'package:flutter/material.dart';
import 'package:leave_app/repetitive/apiurl.dart';
import 'package:http/http.dart' as http;




class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {

  var id = TextEditingController();
  Future deleteUser(int id) async {
    http.Response response =
        await http.delete(Uri.parse('$apionline/users/$id'));
    if (response.statusCode == 200) {
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully deleted')));}
    } else {
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to delete')));}
    }
    
  }

  

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Delete'),),automaticallyImplyLeading: false,),
      body: 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: id,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID',
              ),
            ),
          ),

          ElevatedButton(
            onPressed: (){
              deleteUser(int.parse(id.text));
              
            }, 
            child: const Text('Delete User')),

        
        
        ],
      )
        
          
          
        
      


    );
  }
}