import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leave_app/repetitive/apiurl.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.oneleave});
   final Map oneleave;
   
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var serial = TextEditingController();
   var leave = TextEditingController();
   var formKey = GlobalKey<FormState>();

  Future <bool> update()async{
    try{
      var url = Uri.parse('$apionline/leave-apps/${widget.oneleave['id']}');
    var headers = {"Content-Type":"application/json"};
    var body = jsonEncode({
      "serial_number":serial.text,
      "leave_type":leave.text
    });
  
  http.Response response = await http.put(url, body: body, headers: headers);
  if(response.statusCode == 200){
   
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully updated')));
    }
    else{}
    return true;
  }
  else{
    return false;
  }

    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString())));
      }
      return false;
    }
    
    




  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Center(child: Text("Selected Applications")),
      ),
      body: Column(
        children: [
          
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                  
                    initialValue: widget.oneleave['serial_number'],
                    decoration: const InputDecoration(
                      labelText: 'Serial Number',
                      border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value!.isEmpty || int.tryParse(value) == null){
                        return 'Please enter a valid number';
                      }
                      else if(value == widget.oneleave['serial_number']){
                          return 'Please change the serial number';
                        }
                        else{
                          return null;
                        }
                    },
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.oneleave['leave_type'],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Leave Type',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter input';
                    }
                    else if(value == widget.oneleave['leave_type']){
                          return 'Change the leave type';
                        }
                        else{
                          return null;
                        }
                      
                    
                    }
                  ),
                ),

              ElevatedButton(onPressed: (){
                var isValid = formKey.currentState!.validate();
                if(isValid){
                  try{
                    update();
                    
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: Text(e.toString()),
                    ));
                  }


                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill all the fields correctly'),
                  ));
                }


              }, child:const Text('Update applications')),
              

              ],
            ))

        ],
      ),
      
      
      );
  }
}