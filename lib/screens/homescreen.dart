import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; 

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId){
    donor.doc(docId).delete();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/add');
      },
      backgroundColor: Colors.white,
      child: Icon(Icons.add,color: Colors.red,size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots() , 
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow:[
                        BoxShadow(
                          color: const Color.fromARGB(255, 240, 237, 237),
                          blurRadius: 10,
                          spreadRadius: 15
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(donorSnap['group'],
                              style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(donorSnap['name'],style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(
                              donorSnap['phone'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/update',
                                arguments: {
                                  'name':donorSnap['name'],
                                  'phone': donorSnap['phone'].toString(),
                                  'group': donorSnap['group'],
                                  'id': donorSnap.id,
                                }
                                );
                              }, 
                              icon:Icon(Icons.edit),
                              iconSize: 30,
                              color: Colors.blue,
                              ),
                            IconButton(
                              onPressed: (){
                                deleteDonor(donorSnap.id);
                              }, 
                              icon:Icon(Icons.delete),
                              iconSize: 30,
                              color: Colors.red,
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },);
          }
          return Container();
        },),
    );
  }
}