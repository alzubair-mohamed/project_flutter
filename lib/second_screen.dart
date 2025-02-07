import 'package:flutter/material.dart';
import 'dart:async';

class SecondScreen extends StatelessWidget{
  final List<Map<String, String>> users;
  final bool isDarkMode;
  const SecondScreen({Key? key , required this.users, required this.isDarkMode}) : super (key: key);

  Stream<String> getTimeStream() async*{

    while (true){
      await Future.delayed(const Duration(seconds: 1));
      var DataTime;
      yield DataTime.now().toLocal().toString();
    }
  }

  Future<String> fetchExtraData() async{
    await Future.delayed(const Duration(seconds: 3));
    return "📢 Additional data has been fetched!";
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:  const Text("Second Screen")),
     body: Padding(
       padding: const EdgeInsets.all(16), 
       child: Column(
         children: [
           const SizedBox(height: 10),
           Container(
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: isDarkMode ? Colors.grey[800] : Colors.indigo.shade50,
               borderRadius: BorderRadius.circular(15),
               
             ),
             child: Column(
               children: [
                 const Text("📅 Current time:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 StreamBuilder<String>(
                   stream:  getTimeStream(),
                   builder: (context, snapshot) {
                     return Text(
                       snapshot.data ?? "Loading . . . ",
                       style: TextStyle(fontSize: 18,color: isDarkMode ? Colors.white : Colors.blue),
                     );
                   },
                 ),
                 const SizedBox(height: 10),
                 FutureBuilder<String>(
                   future: fetchExtraData(),
                   builder: (context, snapshot){
                     return Text(
                     snapshot.connectionState == ConnectionState.waiting ? "Loading data...Loading data..." : snapshot.data!,
                     style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.green),
                     );
                     }
                 ),
               ],
             ),
           ),
           const SizedBox(height: 20),
           const Text("👥 User List:",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
           Expanded(
               child: ListView.builder(
                 itemCount: users.length,
                 itemBuilder: (context,index){
                   return Card(
                     margin: const EdgeInsets.symmetric(vertical: 8),
                     elevation: 4,
                     color: isDarkMode ? Colors.grey[900] : Colors.white,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                     child: ListTile(
                       leading: Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.indigo),
                       title:Text("🆔User Name : ${users[index]['username']}",style:TextStyle(color: isDarkMode ? Colors.white : Colors.black) ,),
                       subtitle: Text("🔑Password : ${'*' * users[index]['password']!.length}",  style:TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey[700])),
                       trailing:  const Icon(Icons.lock_outline, color: Colors.grey,),
                     ),
                   );
                 },
               ),
           ),
         ],
       ),
     ), 
    );
  }
  
}
