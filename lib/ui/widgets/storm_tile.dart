import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/ui/widgets/date_range_bubbles.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/ui/views/storm_record_view.dart';

class StormTile extends StatefulWidget {
  final Storm storm;
  final VoidCallback onDismiss;
  final VoidCallback onSave;

  // constructor
  StormTile({@required this.storm, this.onDismiss, this.onSave});

  @override
  StormTileState createState() {
    return new StormTileState();
  }
}

class StormTileState extends State<StormTile> {
  final GlobalKey<StormTileState> _tileKey = new GlobalKey<StormTileState>();

  @override
  Widget build(BuildContext context) {
    int stormId = widget.storm.id;

    return SizedBox.expand(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        )),
        child: InkWell(
          key: _tileKey,
          onTap: () async {
            Storm result = await appUtil.gotoPage(
                context, new StormRecordView(stormId), true);

            if (result != null) {
              widget.onSave();
            }
          },
          child: Dismissible(
            key: new Key(stormId.toString()),
            background: Container(
              color: Theme.of(context).backgroundColor,
              child: new Icon(
                Icons.delete_sweep,
                size: 40.0,
              ),
            ),
            onDismissed: (dir) => widget.onDismiss(),
            child: _buildListTile(widget.storm),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(Storm storm) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 2),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DateRangeBubbles(
            startDate: storm.startDatetime,
            endDate: storm.endDatetime,
          ),
          new Column(children: [
            _buildLevelIconDisplay(Icons.flash_on, storm.intensity),
            _buildLevelIconDisplay(Icons.cloud, storm.flux),
          ]),
          _buildNoteText(storm.notes),
        ],
      ),
    );
  }

  Widget _buildNoteText(String notes) {
    if (notes == null || notes == "") {
      return new SizedBox(
        width: 0.0,
        height: 0.0,
      );
    }

    return IconButton(
      onPressed: () {
        showDialog(
            builder: (BuildContext context) {
              return new Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(notes),
                ),
              );
            },
            context: _tileKey.currentContext);
      },
      icon: Icon(Icons.text_fields),
    );
  }

  Widget _buildLevelIconDisplay(IconData icon, int value) {
    int level = value != null ? value : 0;

    List<Widget> list = new List<Widget>();
    for (int i = 1; i <= 5; i++) {
      list.add(new Icon(
        icon,
        size: 17.0,
        color: i <= level ? Colors.red : Colors.grey.shade300,
      ));
    }

    return new Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Wrap(children: list),
      ),
    );
  }
}
