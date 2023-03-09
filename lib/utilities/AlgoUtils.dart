import 'dart:developer';
import '../enums/algo.dart';

String algoToString(ALGO algo) {
  String target = algo.name.replaceAllMapped(
      RegExp(r'[A-Z]'), (match) => "-${match[0]!.toLowerCase()}");
  log(target);
  return target;
}

ALGO stringToAlgo(String string) {
  List<String> algoStrings = ALGO.values.map((e) => e.toString()).toList();
  List<ALGO> algos = ALGO.values;
  for (var i = 0; i < algos.length; i++)
    if (algoStrings[i].substring(5) == string) return algos[i];
  throw "cannot find appropriate algo";
}
