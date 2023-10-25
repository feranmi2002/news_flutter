import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final String blogUrl;
  @override
  void initState() {
    super.initState();
    blogUrl = widget.blogUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Flutter"),
              Text("News", style: TextStyle(color: Colors.blue))
            ]),
        actions: <Widget>[
          Opacity(opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save),
          ),)
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebWiewStack(url: blogUrl),
      ),
    );
  }
}

class WebWiewStack extends StatefulWidget {

  final String url;
  WebWiewStack({required this.url});

  @override
  State<WebWiewStack> createState() => _WebWiewStackState();
}

class _WebWiewStackState extends State<WebWiewStack> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url){
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress){
        setState(() {
          loadingPercentage = progress;
        });
      },
      onPageFinished: (url){
        setState(() {
          loadingPercentage = 100;
        });
      }
    ))
    ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        if(loadingPercentage < 100)
          LinearProgressIndicator(value: loadingPercentage / 100.0,)
      ],
    );
  }
}

