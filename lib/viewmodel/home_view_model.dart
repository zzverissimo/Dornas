import 'package:url_launcher/url_launcher.dart';


class HomeViewModel {
  void openPDF(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e){
    throw 'No se puede abrir el PDF $url';
  }
  }
}