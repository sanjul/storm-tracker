import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/model/StormRecordState.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';

class StormRecordView extends StatefulWidget {
  final int _stormId;
  StormRecordView(this._stormId);

  int get inputStormId => _stormId;

  static ChangeNotifierProvider init(int stormId) {
    return ChangeNotifierProvider<StormRecordState>(
        builder: (_) {
          StormRecordState state = StormRecordState();
          state.loadStorm(stormId);
          return state;
        },
        child: StormRecordView(stormId));
  }

  @override
  State<StatefulWidget> createState() {
    return new StormRecordViewState();
  }
}

class StormRecordViewState extends State<StormRecordView> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final notesController = new TextEditingController();
  BuildContext _context;
  StormRecordState _state;
  Storm _storm;

  void _setStartDate() async {
    final DateTime picked = await showDatePicker(
        context: _context,
        initialDate: _storm.startDatetime ?? DateTime.now(),
        firstDate: new DateTime(1990),
        lastDate: _storm.startDatetime != null
            ? (_storm.endDatetime ?? DateTime.now())
            : DateTime.now());

    if (picked != null) {
      print("Date selected = " + picked.toIso8601String());
      setState(() {
        _storm.startDatetime = picked;
        if (_storm.endDatetime != null &&
            _storm.endDatetime.isBefore(_storm.startDatetime)) {
          _storm.endDatetime = _storm.startDatetime;
        }
      });
    }
  }

  void _setEndDate() async {
    final DateTime picked = await showDatePicker(
        context: _context,
        initialDate:
            _state.storm.endDatetime ?? _state.storm.startDatetime ?? DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: new DateTime.now());
    if (picked != null) {
      if (_storm.startDatetime != null &&
          picked.isBefore(_storm.startDatetime)) {
        appUtil.showSnackBar(
            _scaffoldKey.currentState, "Invalid end date. Please verify.");
      } else {
        setState(() {
          _storm.endDatetime = picked;
        });
      }
    }
  }

  void _onFormSubmit() {
    if (_formKey.currentState.validate()) {
      _storm.notes = notesController.text;

      if (_storm.startDatetime == null) {
        appUtil.showSnackBar(
            _scaffoldKey.currentState, "Please select start date");
        return;
      }

      _state.saveStorm(widget.inputStormId, _storm).then((stormId) {
        appUtil.popPage(context, this._storm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _state = Provider.of<StormRecordState>(context);
    _storm = _state.storm;
    _context = context;

    Widget _saveButton = new IconButton(
      onPressed: _onFormSubmit,
      icon: new Icon(Icons.done),
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(
            widget._stormId != null && widget._stormId > 0 ? "Edit" : "Add"),
        actions: <Widget>[_saveButton],
      ),
      body: _storm == null
          ? new CircularProgressIndicator()
          : SafeArea(
              top: false,
              bottom: false,
              child: new Form(
                key: _formKey,
                autovalidate: true,
                child: _column(<Widget>[
                  _row(_dateField(
                      "Start Date", _storm.startDatetime, _setStartDate)),
                  _row(_dateField("End Date", _storm.endDatetime, _setEndDate)),
                  _row(
                    _buildSlider(
                      text: 'Intensity',
                      icon: Icons.flash_on,
                      value: _storm.intensity,
                      callback: (intensity) {
                        _storm.intensity = intensity;
                      },
                    ),
                  ),
                  _row(
                    _buildSlider(
                      text: 'Flux',
                      icon: Icons.cloud,
                      value: _storm.flux,
                      callback: (flux) {
                        _storm.flux = flux;
                      },
                    ),
                  ),
                  _notesField(),
                ]),
              ),
            ),
    );
  }

  Widget _row(List<Widget> _children) {
    return new ListTile(
        title: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _children,
    ));
  }

  Widget _column(List<Widget> _children) {
    return new ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: _children,
    );
  }

  List<Widget> _dateField(
      String label, DateTime displayDate, VoidCallback callback) {
    return <Widget>[
      new Row(
        children: <Widget>[
          Icon(Icons.calendar_today),
          Text(label),
        ],
      ),
      new InkWell(
        child: Container(
          width: 200.0,
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
            border: new Border.all(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: new Text(
            displayDate != null
                ? dateUtil.formatDate(displayDate)
                : 'Tap to set date',
          ),
        ),
        onTap: callback,
      )
    ];
  }

  Widget _notesField() {
    notesController.text = _storm.notes;
    TextField _notesInputField = TextField(
      controller: notesController,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Enter your notes about this storm',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(10.0),
      ),
    );

    return new Column(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Icon(Icons.text_fields),
                new Text(" Enter your notes:"),
              ],
            )),
        new Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10.0,
            bottom: 20.0,
          ),
          child: _notesInputField,
        ),
      ],
    );
  }

  List<Widget> _buildSlider(
      {String text, IconData icon, int value, ValueSetter<int> callback}) {
    return <Widget>[
      new Row(
        children: <Widget>[
          new Icon(icon),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: new Text(text),
          ),
        ],
      ),
      new Slider(
        onChanged: (double value) {
          setState(() {
            callback(value.toInt());
          });
        },
        value: value != null ? value.toDouble() : 0.0,
        max: 5.0,
        min: 0.0,
      )
    ];
  }
}
