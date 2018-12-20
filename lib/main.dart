import 'package:flutter/material.dart';
import 'package:hello_scoped/meter.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class CounterModel extends Model {
  int _counter = 40;
  int get counter => _counter;
  void increment() async {
    _counter++;
    notifyListeners();
  }

  void decrement() async {
    _counter--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meter'),
          centerTitle: true,
        ),
        body: new ScopedModel<CounterModel>(
          model: CounterModel(),
          child: new Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 300),
                  ),
                  new ScopedModelDescendant<CounterModel>(
                    builder: (context, child, model) => new Meter(
                          size: 200,
                          percentage: model._counter,
                          strokeSize: 40,
                          backgroundColor: Colors.black,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: new ScopedModelDescendant<CounterModel>(
                      builder: (context, child, model) => new RaisedButton(
                            onPressed: () {
                              model.increment();
                            },
                            child: Text("+"),
                          ),
                    ),
                  ),
                  Container(
                    child: new ScopedModelDescendant<CounterModel>(
                      builder: (context, child, model) => new RaisedButton(
                            onPressed: () {
                              model.decrement();
                            },
                            child: Text("-"),
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
