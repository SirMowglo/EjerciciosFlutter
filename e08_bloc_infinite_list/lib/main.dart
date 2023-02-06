import 'package:bloc/bloc.dart';
import 'package:e08_bloc_infinite_list/simple_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';


void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}
