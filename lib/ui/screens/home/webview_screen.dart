// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PDFViewerPage extends StatefulWidget {
//   final String url;

//   PDFViewerPage({required this.url});

//   @override
//   _PDFViewerPageState createState() => _PDFViewerPageState();
// }

// class _PDFViewerPageState extends State<PDFViewerPage> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Actualizar la barra de progreso
//           },
//           onPageStarted: (String url) {
//             // Página empezó a cargarse
//           },
//           onPageFinished: (String url) {
//             // Página terminó de cargarse
//           },
//           onWebResourceError: (WebResourceError error) {
//             // Manejar errores
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Visualizador de PDF'),
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
