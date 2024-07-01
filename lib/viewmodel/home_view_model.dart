import 'package:url_launcher/url_launcher.dart';

class HomeViewModel {
   Future<void> openURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'La $url no existe o no se puede abrir.';
    }
  }
}
