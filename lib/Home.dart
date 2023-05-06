// ignore: file_names
import 'dart:convert';
import 'dart:html';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:teachable/teachable.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pose = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pose Classifier"),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(children: <Widget>[
                Container(
                  child: Expanded(
                    child: Teachable(
                      path: "pose/index.html",
                      results: (res) {
                        var resp = jsonDecode(res);
                        print("The values are $resp");
                        setState(() {
                          pose = (resp['Tree Pose'] * 100.0).toString();
                        });
                      },
                    ),
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "TREE POSE",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            pose,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}

// class MyHome extends StatefulWidget {
//   MyHome({Key? key}) : super(key: key);

 

//   @override
//   _MyHomeState createState() => _MyHomeState();
// }
// class _MyHomeState extends State<MyHome> {
//   late InAppWebViewController webView;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await webView.canGoBack()) {
//           webView.goBack();
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: Container(
//             child: Column(children: <Widget>[
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.only(top: 30.0),
//               child: InAppWebView(
//                 // initialFile: "http://localhost:8080/assets/index.html",
//                 onWebViewCreated: (InAppWebViewController controller) {
//                   webView = controller;
//                   webView.loadFile(assetFilePath: "assets/index.html");
//                 },
//               ),
//             ),
//           )
//         ])),
//       ),
//     );
//   }
// }




// class TeachableMachineWebView extends StatefulWidget {
//   final String endpointUrl;

//   TeachableMachineWebView({required this.endpointUrl});

//   @override
//   _TeachableMachineWebViewState createState() => _TeachableMachineWebViewState();
// }

// class _TeachableMachineWebViewState extends State<TeachableMachineWebView> {
//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: widget.endpointUrl,
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (controller) {
//         _controller = controller;
//       },
//       onPageFinished: (url) async {
//         final poseEstimations = await _controller.evaluateJavascript('''
//           // Get the keypoints from the page
//           const keypoints = JSON.parse(document.querySelector('#output').textContent);

//           // Send the keypoints to the Teachable Machine model's endpoint
//           const response = await fetch('${widget.endpointUrl}', {
//             method: 'POST',
//             headers: { 'Content-Type': 'application/json' },
//             body: JSON.stringify({ data: [keypoints] })
//           });

//           // Parse the response JSON and return it
//           return response.json();
//         ''');

//         // Handle the pose estimations
//         final jsonData = jsonDecode(poseEstimations);
//         print(jsonData);
//       },
//     );
//   }
// }

