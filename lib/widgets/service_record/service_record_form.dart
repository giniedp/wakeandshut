import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wakeandshut/services/storage/index.dart';
import 'package:wakeandshut/services/discovery/index.dart';
import 'package:wakeandshut/model/service_record.dart';

class ServiceRecordForm extends StatefulWidget {
  static final String routeName = '/recordForm';

  static void navigate(BuildContext context,
      {ServiceRecord record, ServiceInfo info}) {
    record ??= ServiceRecord(service: info?.name);
    Navigator.pushNamed(context, routeName, arguments: record);
  }

  static ServiceRecord routeArgument(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }

  final ServiceRecord record;
  ServiceRecordForm(this.record);

  @override
  ServiceRecordFormState createState() {
    return ServiceRecordFormState();
  }
}

class ServiceRecordFormState extends State {
  final _formKey = GlobalKey<FormState>();

  final _result = ServiceRecord();
  final _textControlMac = TextEditingController();
  final _textControlAddress = TextEditingController();
  bool _initDone = false;

  @override
  void dispose() {
    _textControlMac.dispose();
    super.dispose();
  }

  void initData(BuildContext context) {
    if (_initDone) {
      return;
    }
    _initDone = true;

    var record = ServiceRecordForm.routeArgument(context);
    if (record != null) {
      _result.id = record.id;
      _result.mac = record.mac;
      _result.kind = record.kind;
      _result.address = record.address;
      _result.service = record.service;
    }

    if (_result.id.isEmpty) {
      if (_result.mac.isEmpty) {
        _result.mac = _resolveMacAddress(context);
      }
      if (_result.address.isEmpty) {
        _result.address = _resolveAddress(context);
      }
    }

    _textControlMac.text = _result.mac;
    _textControlAddress.text = _result.address;
  }

  void _onSaveClicked(BuildContext context) {
    var state = _formKey.currentState;
    if (!state.validate()) {
      return;
    }

    state.save();
    setState(() {
      Provider.of<Storage>(context).putRecord(_result);
      print(_result.toMap());
    });
    Navigator.pop(context, _result);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Entry saved')));
  }

  void _onDeleteClicked(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Confirm to delete service entry'),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<Storage>(context).deleteRecord(_result.id);
                Navigator.pop(context);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Entry deleted')));
              },
            ),
          ],
        );
      },
    );
  }

  String _resolveMacAddress(BuildContext context) {
    var service = Provider.of<DiscoveryList>(context)
        .items
        .firstWhere((it) => it.name == _result.service, orElse: () => null);

    return String.fromCharCodes((service?.attr ?? {})['mac'] ?? []);
  }

  String _resolveAddress(BuildContext context) {
    return Provider.of<DiscoveryList>(context)
            .items
            .firstWhere((it) => it.name == _result.service, orElse: () => null)
            ?.address ??
        '';
  }

  void _updateMacAddress() {
    _textControlMac.text = _resolveMacAddress(context);
  }

  void _updateAddress() {
    _textControlAddress.text = _resolveAddress(context);
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> result = [];
    result.add(
      IconButton(
        icon: Icon(Icons.check),
        onPressed: () => _onSaveClicked(context),
      ),
    );
    if (_result.id.isNotEmpty) {
      result.add(
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _onDeleteClicked(context),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    initData(context);
    var discovered = Provider.of<DiscoveryList>(context).items;
    var options = discovered.map((it) => it.name).toList();
    if (!options.contains(_result.service)) {
      options.add(_result.service);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service'),
        actions: _buildActions(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                value: _result.kind,
                hint: Text('Pick a service kind'),
                items: ServiceKind.values.map((it) {
                  return DropdownMenuItem(
                    value: it,
                    child: Text(it.toString().split('.')[1]),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Service kind'),
                onChanged: (ServiceKind value) {
                  setState(() => _result.kind = value);
                },
                onSaved: (ServiceKind value) {
                  setState(() => _result.kind = value);
                },
              ),
              DropdownButtonFormField(
                value: _result.service,
                hint: Text('Pick a service'),
                items: options.map((it) {
                  return DropdownMenuItem(
                    value: it,
                    child: SizedBox(
                      width: 300.0,
                      child: Text(it, overflow: TextOverflow.ellipsis),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Service instance'),
                onChanged: (String value) {
                  setState(() => _result.service = value);
                  _updateMacAddress();
                  _updateAddress();
                },
                onSaved: (String value) {
                  setState(() => _result.service = value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mac',
                  suffixIcon: IconButton(
                    icon: Icon(FontAwesomeIcons.magic),
                    onPressed: _updateMacAddress,
                  ),
                ),
                controller: _textControlMac,
                onSaved: (value) => setState(() => _result.mac = value),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  suffixIcon: IconButton(
                    icon: Icon(FontAwesomeIcons.magic),
                    onPressed: _updateAddress,
                  ),
                ),
                controller: _textControlAddress,
                onSaved: (value) => setState(() => _result.address = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
