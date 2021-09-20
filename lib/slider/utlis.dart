import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openLink({
      String url,
    }) =>
     _lunchUrl(url);

  static Future _lunchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("erer");
    }
  }
}