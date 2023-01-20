import 'package:colorful/models/ColorScheme.dart' as cs;
import 'package:colorful/models/color.dart';
import 'package:colorful/services/ColorService.dart';
import '../../../constants/EntryViewconstants.dart' as constant;

class EntryViewModel {
  final int schemeCount = constant.schemeCount;
  ColorService _service = ColorService();
  Future<List<cs.ColorScheme>>? colors;
  EntryViewModel() {
    init();
  }
  Future init() async {
    colors = _service.getMultipleColorSchemes();
  }
}
