import 'package:colorful/enums/algo.dart';
import 'package:colorful/models/ColorScheme.dart' as cs;
import 'package:colorful/models/Hex.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/services/ColorService.dart';
import 'package:colorful/services/NetworkService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../constants/EntryViewconstants.dart' as constant;
import '../../../models/ColorScheme.dart';
import '../../../models/LocalUser.dart';

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

  Future<void> swipeLeft(ColorScheme scheme, ALGO algo) async {
    return;
    //todo: я даже допиливать это не хочу, такая хуйня конечно
    var instance = Supabase.instance.client;
    for (var color in scheme.colors) {
      await instance.from("colors").insert({
        'color_name': color.name,
        "created_by": LocalUser.instance!.uuid,
        "hex": Hex.fromGroup(group: color.rgb!)
      });
    }
    await instance.from("algorithms").insert({"name": algo.name});
    await instance
        .from("colorschemes")
        .insert({"created_by": LocalUser.instance!.uuid});
    await instance.from("colors_in_schemas").insert("");
  }

  Future<void> swipeRight(ColorScheme scheme, ALGO algo) async {
    return;
    //todo: ну и пиздос
    var instance = Supabase.instance.client;
    for (var color in scheme.colors) {
      await instance.from("colors").insert({
        'color_name': color.name,
        "created_by": LocalUser.instance!.email,
        "hex": Hex.fromGroup(group: color.rgb!)
      });
    }
  }
}
