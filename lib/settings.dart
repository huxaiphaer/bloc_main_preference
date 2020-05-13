import 'package:blocmainpreference/models/color.dart';
import 'package:blocmainpreference/providers/preference_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PreferenceProvider>(context).bloc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: GestureDetector(
          onTap: () {
            //TODO: Save settings
            bloc.savePreferences();
            Navigator.of(context).pop();
          },
          child: Icon(CupertinoIcons.back),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Dark Mode'),
                  StreamBuilder<Brightness>(
                    stream: bloc.brightness,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData){
                        return Container();
                      }
                      return Switch(
                        value:
                            (snapshot.data == Brightness.light) ? false : true,
                        onChanged: (bool value) {
                          if (value) {
                            bloc.changeBrightness(Brightness.dark);
                          } else {
                            bloc.changeBrightness(Brightness.light);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Primary Color'),
                  StreamBuilder<ColorModel>(
                    stream: bloc.primaryColor,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData){
                        return Container();
                      }
                      return Slider(
                        value: snapshot.data.index,
                        min: 0.0,
                        max: 3.0,
                        divisions: 3,
                        label: snapshot.data.name,
                        onChanged: (double value) {
                          bloc.changePrimaryColor(
                              bloc.indexToPrimaryColor(value));
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
