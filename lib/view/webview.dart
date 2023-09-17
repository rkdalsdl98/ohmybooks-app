import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class WebView extends StatefulWidget {
  String pageUrl;
  WebView({
    Key? key,
    required this.pageUrl,
  }) : super(key: key);

  @override
  State<WebView> createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  final GlobalKey webViewKey = GlobalKey();
  late final InAppWebViewController webViewController;
  double progress = 0;
  late Uri uri;

  @override
  void initState() {
    super.initState();
    uri = Uri.parse(widget.pageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Column(children: <Widget>[
            progress < 1.0
                ? LinearProgressIndicator(value: progress, color: Colors.blue)
                : Container(),
            Expanded(
                child: Stack(children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: uri),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      javaScriptCanOpenWindowsAutomatically: true,
                      javaScriptEnabled: true,
                      useOnDownloadStart: true,
                      useOnLoadResource: true,
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: true,
                      allowFileAccessFromFileURLs: false,
                      allowUniversalAccessFromFileURLs: true,
                      verticalScrollBarEnabled: true,
                      userAgent:
                          'Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36'),
                  android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                      allowContentAccess: true,
                      builtInZoomControls: true,
                      thirdPartyCookiesEnabled: true,
                      allowFileAccess: true,
                      supportMultipleWindows: true),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: true,
                    allowsBackForwardNavigationGestures: true,
                  ),
                ),
                onLoadStop: (InAppWebViewController controller, newUri) {
                  setState(() {
                    uri = newUri!;
                  });
                },
                onCreateWindow: (controller, createWindowRequest) async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 400 * getScaleFactorFromHeight(context),
                          child: InAppWebView(
                            windowId: createWindowRequest.windowId,
                            initialOptions: InAppWebViewGroupOptions(
                              android: AndroidInAppWebViewOptions(
                                builtInZoomControls: true,
                                thirdPartyCookiesEnabled: true,
                              ),
                              crossPlatform: InAppWebViewOptions(
                                mediaPlaybackRequiresUserGesture: false,
                                cacheEnabled: true,
                                javaScriptEnabled: true,
                                userAgent:
                                    "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
                              ),
                              ios: IOSInAppWebViewOptions(
                                allowsInlineMediaPlayback: true,
                                allowsBackForwardNavigationGestures: true,
                              ),
                            ),
                            onCloseWindow: (controller) async {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                  return true;
                },
              )
            ]))
          ]),
        ),
      ),
    );
  }
}
