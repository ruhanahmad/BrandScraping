// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:scrapingdart/main.dart';
// import 'package:flutter/material.dart';
// import 'package:scrapingdart/test/cubit/cubit_state.dart';
// import 'package:scrapingdart/test/cubit/cubit_todo.dart';


// class TODOSCRAPE extends StatefulWidget {
//   const TODOSCRAPE({super.key});

//   @override
//   State<TODOSCRAPE> createState() => _TODOSCRAPEState();
// }


// class _TODOSCRAPEState extends State<TODOSCRAPE> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // final cubit = context.read<Todocubit>();
//     // cubit.insan();
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 

//     //   final cubit = context.read<Todocubit>();

//     //   cubit.insan();
//     // });
//   }
//   @override


//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: 
// BlocBuilder<Todocubit,TodoState>(
//   builder:(context, state) {
     
//        if (state is incrementState  ){
   
//     return   Center(child: 
//        CircularProgressIndicator());
    
//   }
 
//   // if (state is circularTodoState  ){
   
//   //      Center(child: 
//   //      CircularProgressIndicator());
    
//   // }
    
   
  
//   //   if (state is incrementState ){
//   //    return 
//   //    Center(child: Text("asd"));
//   // }

//  return  Center(child: GestureDetector(
//   onTap: () {
//     BlocProvider.of<Todocubit>(context).insan();
//   },
//   child: ElevatedButton(onPressed: (){

//   }, child: Text("${state}"))
  
//   ));
// }


// ) )
//     ;
//   }



// }