import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/ui/date_range_bubbles.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/views/storm_record_view.dart';

class StatusTile extends StatefulWidget {
  final Storm storm;
  final VoidCallback onSave;
  final VoidCallback onStopStorm;

  // constructor
  StatusTile({@required this.storm, this.onSave, this.onStopStorm});

  @override
  State<StatefulWidget> createState() {
    return new StatusTileState();
  }
}

class StatusTileState extends State<StatusTile> {
  final GlobalKey<StatusTileState> _tileKey = new GlobalKey<StatusTileState>();

  @override
  Widget build(BuildContext context) {
    int stormId = widget.storm.id;

    return new InkWell(
        key: _tileKey,
        onTap: () async {
          Storm result = await appUtil.gotoPage(
              context, new StormRecordView(stormId), true);

          if (result != null) {
            widget.onSave();
          }
        },
        child: _buildListTile(widget.storm));
  }

  Widget _buildListTile(Storm storm) {
    return ListTile(
      title: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DateRangeBubbles(
            startDate: storm.startDatetime,
            endDate: storm.endDatetime,
          ),
        ],
      ),
      trailing: (widget.onStopStorm != null && storm.endDatetime == null)
          ? InkWell(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.stop,
                    color: Colors.red,
                  ),
                  Text('Stop'),
                ],
              ),
              onTap: () {
                StormsData _stormsData = new Injector().stormsData;
                storm.endDatetime = DateTime.now();
                _stormsData
                    .saveStormRecord(storm.id, storm)
                    .then((stormId) => widget.onSave())
                    .then((stormId) => widget.onStopStorm());
              },
            )
          : null,
    );
  }
}
