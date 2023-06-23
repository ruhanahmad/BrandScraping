import 'package:flutter/material.dart';


abstract class TodoState {}

class initTodoState extends TodoState {}
class circularTodoState extends TodoState {}

class incrementState extends TodoState{}
class decrementState extends TodoState{}


