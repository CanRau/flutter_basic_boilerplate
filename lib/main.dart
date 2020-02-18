import 'package:flutter/material.dart';
import 'package:boilerplate/bloc/bloc_from_scratch.dart';
import 'package:boilerplate/ui/global/theme/app_themes.dart';
import 'package:boilerplate/ui/global/theme/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (BuildContext context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Boilerplate',
      theme: state.themeData,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterBloc _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        semanticLabel: 'App Drawer',
        child: ListView(
          children: <Widget>[
            const Text('Test'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppTheme.values.map((AppTheme itemAppTheme) {
                final ThemeData theme = appThemeData[itemAppTheme];
                // return RawMaterialButton(
                //   onPressed: () {
                //     BlocProvider.of<ThemeBloc>(context).add(
                //       ThemeChanged(theme: itemAppTheme),
                //     );
                //     // Navigator.of(context).pop();
                //   },
                //   // child: CircleAvatar(
                //   //   backgroundColor: theme.primaryColor,
                //   // ),
                //   shape: const CircleBorder(),
                //   elevation: 2.0,
                //   fillColor: theme.primaryColor,
                // );
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ClipOval(
                    child: Material(
                      color: theme.primaryColor,
                      child: InkWell(
                        splashColor: theme.backgroundColor,
                        onTap: () {
                          BlocProvider.of<ThemeBloc>(context).add(
                            ThemeChanged(theme: itemAppTheme),
                          );
                          Navigator.of(context).pop();
                        }, // inkwell color
                        child: const SizedBox(width: 56, height: 56),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        // Column(children: <Widget>[
        //   const Text('Themes'),
        //   Expanded(
        //               child: ListView.builder(
        //       itemCount: AppTheme.values.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         final AppTheme itemAppTheme = AppTheme.values[index];
        //         return ListTile(
        //           leading: CircleAvatar(
        //             backgroundColor: appThemeData[itemAppTheme].primaryColor,
        //           ),
        //           title: const Text('test'),
        //           onTap: () => BlocProvider.of<ThemeBloc>(context).add(
        //             ThemeChanged(theme: itemAppTheme),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ]),
      ),
      body: StreamBuilder<int>(
        stream: _bloc.counter,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(ResetEvent()),
            tooltip: 'Reset',
            child: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
