import '../cachhelper/chachhelpe.dart';

bool isloggin = false;
checkislogin() async {
  int? token = await SharedPreferencesHelper.getId();
  if (token != null) {
    isloggin = true;
  } else {
    isloggin = false;
  }
}
