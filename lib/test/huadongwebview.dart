import 'package:flutter/material.dart';

class huadongwebview extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  double top = -1;
  double tempTop = -1;
  double lastY = 0;
  double normalTop = 0;


  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    //启动动画
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (top == -1) {
      normalTop = MediaQuery.of(context).size.height * 0.72;
      print('============normalTop===$normalTop');
      top = normalTop; //设置最小高度
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Listener(
          onPointerUp: (e) {
            setState(() {
              top = tempTop;

              print('============top===$top');
            });
          },
          onPointerMove: (e) {
            if (e.localPosition.dy >= normalTop) {
              if (e.localPosition.dy >= lastY && top >= normalTop) {

                tempTop = 0;
              }
            }
            lastY = e.localPosition.dy;
            print('============lastY===$lastY');
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.7,
                child: NotificationListener(
                  // ignore: missing_return
                  onNotification: (ScrollNotification note) {
                    if (note.metrics.pixels.toInt() >
                        note.metrics.maxScrollExtent.toInt() + 10) {
                      if (top != 0) {
                        tempTop = 0;
                      }
                    }
                  },
                  child: Container(
                    color: Colors.red,
                    child: ListView.builder(
                        itemExtent: 50,
                        itemCount: 20,
                        itemBuilder: (ctx, index) {
                          return Center(
                              child: Container(
                            child: const Text("test"),
                          ));
                        }),
                  ),
                ),
              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}
