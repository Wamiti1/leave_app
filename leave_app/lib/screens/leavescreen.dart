//import 'dart:convert';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leave_app/repetitive/apiurl.dart';
import 'package:leave_app/screens/myleaves.dart';
import 'package:leave_app/screens/users.dart';


class Leavescreen extends StatefulWidget {
  const Leavescreen({super.key, required this.results});
  final Map results;


 
  @override
  State<Leavescreen> createState() => _LeavescreenState();
}

class _LeavescreenState extends State<Leavescreen> {
  final formKey = GlobalKey<FormState>();
  var serial = TextEditingController(text: Random().nextInt(340908989).toString());
  var leave = TextEditingController();
  var userid = TextEditingController();

  Future <bool> postUsertoDB() async{

    try{
       Map<String,dynamic> results= {
                  'serial_number': serial.text,
                  'leave_type': leave.text,
                  'user_id': userid.text,   
    };
       //url
    final url = Uri.parse('$apionline/apply');
    // headers
    var headers ={"Content-Type":"application/json"};
    // body
    var body = jsonEncode(results);

    http.Response response =  await http.post(url, body: body,headers: headers );
    //Confirm the request is successful
      if(response.statusCode == 200){
        //Operation was successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)), 
          duration: const Duration(milliseconds: 5000),));
        return true;
      }
      
      else{
      // we knorew operation was unsuccessful
      return false;

      }

    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),duration: const Duration(milliseconds: 5000)));
        return false;
    }
   


  }

  String time(){
    if(DateTime.now().hour >= 6 && DateTime.now().hour < 12){
      return 'Good Morning ${widget.results['firstname']}';

    }
    else if(DateTime.now().hour >= 12 && DateTime.now().hour <= 16){
      return 'Good Afternoon ${widget.results['firstname']}';
    }
    else if(DateTime.now().hour > 16 && DateTime.now().hour <= 21){
      return 'Good Evening ${widget.results['firstname']}';
    }
    else{
      return 'Good Night ${widget.results['firstname']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Center(
          child: Column(
            children: [
              Text(time(), style: const TextStyle(fontSize: 25.0),),
              Text('${(widget.results['email']).split('@')[0]}',  style: const TextStyle(fontSize: 12.0),),
                 
            ],
          ),
        )
      ),
      
  body: ListView(
        children:[ Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      
                      controller: serial,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Serial Number',
                          hintText: 'e.g 2',
                          prefixIcon: Icon(Icons.numbers_outlined)
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value){
                            if(value!.isEmpty || int.tryParse(value) == null){
                              return 'Enter a valid number';
                            }
                            else{
                              return null;
                            }
                        },
                    ),
                  ),
        
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: leave,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Leave Type',
                          hintText: 'e.g Maternity',
                          prefixIcon: Icon(Icons.menu_book_outlined)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                            if(value!.isEmpty || int.tryParse(value) != null){
                              return 'Enter a valid input';
                            }
                            else{
                              return null;
                            }
                        },
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: userid,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Id',
                          hintText: 'e.g. 2',
                          prefixIcon: Icon(Icons.person_2_rounded)
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(value!.isEmpty || int.tryParse(value) == null){
                              return 'Enter a valid number';
                            }
                            else{
                              return null;
                            }
                            
                        },
                    ),
                  ),
        
        
                  
                ],
              )
              ),
        
          ElevatedButton(
            onPressed: (){
              var isValid = formKey.currentState!.validate();
              if(isValid){
                try{
        
                 
                postUsertoDB().then((value){
                  if(value == true){
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Application was successful')));
                     
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                  }
                })
;        
                
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
                
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your input fields')));
              }
        
        
        
            }, 
            child: const Text('Apply for leave')),
        
        OutlinedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> const LeaveApplications()));
        }, 
        child: const Text('Leave Applications')),

         OutlinedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> const Users()));
        }, 
        child: const Text('Users')),

          ],
        ),
      ]),

      );
  }
}