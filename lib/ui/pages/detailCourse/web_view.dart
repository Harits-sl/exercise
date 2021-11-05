import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViews extends StatefulWidget {
  final String trailerKelas;
  const WebViews({
    Key? key,
    required this.trailerKelas,
  }) : super(key: key);

  @override
  _WebViewsState createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   String iframeUrl = 'https://www.youtube.com/watch?v=I6_gbsbo_1c';
    //   double width = MediaQuery.of(context).size.width;
    //   double height = MediaQuery.of(context).size.height;

    //   String html = """
    //         <iframe
    //         frameborder="0"
    //         allowfullscreen="1"
    //         allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    //         webkitallowfullscreen mozallowfullscreen allowfullscreen
    //         frameborder="0"
    //         src="https://www.youtube.com/watch?v=I6_gbsbo_1c"
    //         ></iframe>
    // """;

    //   String html1 = """
    //                 <html>
    //                   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    //                   <style>
    //                     html{
    //                       height: 200px;
    //                     }
    //                     body{
    //                       background-color: red;
    //                       height: 200px;
    //                     }
    //                   </style>
    //                   <body>
    //                     <iframe frameborder="0"
    //                     width="320px"
    //                     height="200px"
    //                     allowfullscreen="1"
    //                     allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    //                     webkitallowfullscreen mozallowfullscreen allowfullscreen
    //                     frameborder="0"
    //                     src="https://www.youtube.com/embed/${widget.trailerKelas}">
    //                     </iframe>
    //                   </body>
    //                 </html>
    //               """;

    //   final Completer<WebViewController> _controller =
    //       Completer<WebViewController>();
    //   final String contentBase64 =
    //       base64Encode(const Utf8Encoder().convert(html));

    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(
        url: Uri.parse("https://www.youtube.com/embed/${widget.trailerKelas}"),
      ),
      initialOptions: options,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
    );
  }
}
