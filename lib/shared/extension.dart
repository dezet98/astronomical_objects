import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ObjectExt<T> on T {
  R let<R>(R Function(T it) e) => e(this);
}

extension BlocExtension on BuildContext {
  T bloc<T extends Bloc>() {
    return BlocProvider.of<T>(this);
  }
}
