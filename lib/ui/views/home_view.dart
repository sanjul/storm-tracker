import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/HomeState.dart';
import 'package:stormtr/ui/widgets/Cover.dart';
import 'package:stormtr/ui/widgets/RecordControlButton.dart';
import 'package:stormtr/ui/widgets/WelcomeNote.dart';
import 'package:stormtr/ui/widgets/insights.dart';

class HomeView extends StatelessWidget {
  static ChangeNotifierProvider init() {
    return ChangeNotifierProvider<HomeState>(
        builder: (_) {
          HomeState state = HomeState();
          state.loadHome();
          return state;
        },
        child: HomeView());
  }

  @override
  Widget build(BuildContext context) {
    HomeState _homeState = Provider.of<HomeState>(context);

    if (_homeState.homeData != null) {
      return Scaffold(
        floatingActionButton: RecordControllButton(RecContrlBtnType.StormStart),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _homeState.homeData.isNotEmpty
            ? homeBody(context)
            : WelcomeNote("Tap the record button when a storm begins"),
      );
    } else {
      return showProgress();
    }
  }

  Widget homeBody(BuildContext context) {
    HomeState _homeState = Provider.of<HomeState>(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 190,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(children: <Widget>[
              Cover(),
              _buildMarkStormEndButton(context)
            ],),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
              Insights(data: _homeState.homeData).getWidgetList(context)),
        ),
        // Insights(data:_homeState.homeData),
        // _buildMarkStormEndButton(context)
      ],
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildMarkStormEndButton(BuildContext context) {
    HomeState _homeState = Provider.of<HomeState>(context);

    if (_homeState.mood == Mood.SUNNY_DAY) {
      return Container();
    }

    return Animator(
      tweenMap: {
        "pos": _homeState.getTween(90, 150),
        "opacity": _homeState.getTween(1, 0),
      },
      cycles: 1,
      duration: Duration(seconds: 1),
      builderMap: (Map<String, Animation> anim) => Align(
            alignment: Alignment(0, 0),
            child: Opacity(
              opacity: anim["opacity"].value,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: anim["pos"].value),
                    RecordControllButton(RecContrlBtnType.StormEnd),
                  ]),
            ),
          ),
    );
  }
}
