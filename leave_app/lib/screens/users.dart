import 'package:flutter/material.dart';
import 'package:leave_app/screens/components/delete.dart';
import 'package:leave_app/screens/components/get.dart';
import 'package:leave_app/screens/components/post.dart';
import 'package:leave_app/screens/components/put.dart';

class Users extends StatefulWidget {
  const Users({super.key});
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  int currentindex = 0;
  List<Widget> pages = [const Post(),const Put(),const Get(),const Delete()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.home)),
        title: const Text('User profiles'),
        
      ),

    body: pages[currentindex],



      //bottomNavigationBar - POST,DELETE,GET,PUT
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index){
          setState(() {
            currentindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
          BottomNavigationBarItem(icon: Icon(Icons.get_app), label: 'Get'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete')

        ]),

    );
  }
}