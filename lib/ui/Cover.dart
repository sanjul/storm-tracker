import 'package:animator/animator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/state/HomeState.dart';
import 'package:stormtr/ui/CoverClipper.dart';
import 'package:stormtr/ui/status_tile.dart';

const String ASSET_SUNNY_DAY_IMAGE = 'assets/graphics/cover_lights.jpeg';

class Cover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCover(context);
  }
}

Widget _buildCover(BuildContext context) {
  HomeState _homeState = Provider.of<HomeState>(context);
  bool isSunny = _homeState.mood == Mood.SUNNY_DAY;

  return Container(
    height: 150,
    child: Animator(
      tweenMap: {"curveOffset": _homeState.getTween(0,60),
                 "shadowBlur": _homeState.getTween(150, 600),
                 "shadowOffset": _homeState.getTween(10, -200),},
      cycles: 1,
      duration: Duration(seconds: 1),
      builderMap: (Map<String, Animation> anim) => ClipPath(
            clipper: CoverClipper(anim["curveOffset"].value),
            child: Container(
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: AnimatedContainer(
                      foregroundDecoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            blurRadius: anim["shadowBlur"].value,
                            color: Colors.black,
                            offset: Offset(150, anim["shadowOffset"].value),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ASSET_SUNNY_DAY_IMAGE),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  ),
                  _buildMoodAnimation(context),
                  showLastStormAndCaption(context),
                ],
              ),
            ),
          ),
    ),
  );
}

Widget _buildMoodAnimation(BuildContext context) {
  return Container(
    height: 150,
    child: FlareActor(
      'assets/animations/sunandstorm.flr',
      fit: BoxFit.contain,
      alignment: Alignment.bottomRight,
      animation: Provider.of<HomeState>(context).getAnimationName(),
      callback: (a) {
        Provider.of<HomeState>(context).setAsAnimLoopStarted();
      },
    ),
  );
}

Widget showLastStorm(BuildContext context) {
  HomeState _homeState = Provider.of<HomeState>(context);

  return StatusTile(
    storm: _homeState.homeData.lastStorm,
    onSave: () => _homeState.loadHome(),
    isSpecial: true,
  );
}

Widget showLastStormAndCaption(BuildContext context) {
  HomeState _homeState = Provider.of<HomeState>(context);
  Widget _caption;
  if (_homeState.homeData.lastStorm.endDateDB == null) {
    _caption = _stormCaption(Icons.update, "In progress", context);
  } else {
    _caption = _stormCaption(Icons.event_available, "Completed", context);
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _caption,
      showLastStorm(context),
    ],
  );
}

Widget _stormCaption(IconData icon, String caption, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      SizedBox(
        width: 5.0,
      ),
      Text(
        caption,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ],
  );
}
