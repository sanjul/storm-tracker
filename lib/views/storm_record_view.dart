import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/views/home_view.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';
import 'package:stormtr/modules/storm_record_presenter.dart';

class StormRecordView extends StatefulWidget {
  final DateTime _startDate;
  StormRecordView(this._startDate);

  DateTime get inputDate => _startDate;

  @override
  State<StatefulWidget> createState() {
    return new StormRecordViewState();
  }
}

class StormRecordViewState extends State<StormRecordView>
    implements StormsRecordViewContract {
  StormsRecordPresenter _presenter;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Storm _storm;
  BuildContext _context;

  //constructor
  StormRecordViewState() {
    _presenter = new StormsRecordPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadStorm(widget.inputDate);
  }

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
        initialDate: _storm.endDatetime ?? DateTime.now(),
        firstDate: _storm.startDatetime ?? DateTime(1990),
        lastDate: new DateTime.now());
    if (picked != null) {
      setState(() {
        _storm.endDatetime = picked;
      });
    }
  }

  void _onFormSubmit() {
    if (_formKey.currentState.validate()) {
      if (_storm.startDatetime == null) {
        appUtil.showSnackBar(
            _scaffoldKey.currentState, "Please select start date");
        return;
      }

      _presenter.saveStorm(_storm);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Record Storm Details"),
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
                  new Container(
                      padding: const EdgeInsets.all(10.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _onFormSubmit,
                      )),
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
      new Text(label),
      new InkWell(
        child: Container(
            padding: new EdgeInsets.all(10.0),
            child: new Text(dateUtil.formatDate(displayDate))),
        onTap: callback,
      )
    ];
  }

  @override
  void onLoadStormComplete(Storm storm) {
    setState(() {
      this._storm = storm == null ? new Storm() : storm;
    });
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void onSaveStormComplete(bool isInserted) {
    appUtil.gotoPage(context, new HomeView());
  }
}

// child: new ListView(
//   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//   children: <Widget>[
//     new Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         new Icon(Icons.calendar_today),
//         new Padding(padding: new EdgeInsetsDirectional.only(start: 15.0),
//          child: new Text("Start"),),
// new InkWell(
//   child: new Text(appUtil.getFormatedCurrentDate()),
//   onTap: () async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: new DateTime(2016),
//         lastDate: DateTime.now());

//     print("Date selected = " + picked.toString());
//   },
//         ),
//       ],
//     ),
//     new TextFormField(
//       decoration: const InputDecoration(
//         icon: const Icon(Icons.calendar_today),
//         hintText: 'Enter when the storm ended',
//         labelText: 'End',
//       ),
//     ),
// new TextFormField(
//   decoration: const InputDecoration(
//     icon: const Icon(Icons.description),
//     hintText: 'Enter your notes about this storm',
//     labelText: 'Notes',
//   ),
// ),
// new Container(
//     padding: const EdgeInsets.only(left: 40.0, top: 20.0),
//     child: new RaisedButton(
//       child: const Text('Submit'),
//       onPressed: null,
//     )),
//   ],
