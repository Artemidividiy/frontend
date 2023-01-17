import 'package:colorful/enums/algo.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/services/ColorService.dart';

class HomeViewModel {
  ColorService _colorService = ColorService();
  ALGO algo = ALGO.monochrome;
  late Future<List<ColorModel>?> currentScheme;
  HomeViewModel() {
    this.currentScheme = _colorService.getRandomColorsWithAlgo(algo: algo);
  }

  Future<List<ColorModel>?> fetch() async {
    var target = _colorService.getRandomColorsWithAlgo(algo: algo);
    if (target != null) return currentScheme = target;
    // currentScheme = target;
  }
}
