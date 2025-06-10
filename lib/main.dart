import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: WebViewExample()));

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});
  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  static const String urlLoginDev = 'https://login-integracionesdev.a3software.com/authorize?name=A3facturaMobile&product=a3factura&scope=subscription';
  static const String urlGetToken = "https://login-integracionesdev.a3software.com/api/tokens/registerToken?name=A3facturaMobile&code=";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Flutter WebView Example Login')
      ),
      body: WebViewWidget(controller: _controller),  
    );
  }

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {              
            if (request.url.contains('localhost')) {
              getToken(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }          
        ),
      )
      ..loadRequest(Uri.parse(urlLoginDev));
    _controller = controller;
  }



  Future<void> openDialog2(String texto, String url) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'URL: $url',
                style: TextStyle(fontSize: 16.0),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Text(
                  'Body: $texto',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

   Future<void> getToken(String url) async {
      Uri uri = Uri.parse(url);
      String? code = uri.queryParameters['code'];
      var urlLocal = Uri.parse(urlGetToken +code.toString());
      var response = await http.get(urlLocal);
      var json = response.body;
      openDialog2(json, url + '\n\n' + urlLocal.toString());      
  }
}
