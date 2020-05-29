import 'dart:async';

import 'package:goorlanews/bimbi/models/customer.dart';
import 'package:goorlanews/bimbi/services/bimbyApi.dart';

class BimbiBloc {
  final BimbyApi _bimby = BimbyApi();

  Stream<List<Customer>> get customers => _customers.stream;

  Customer _selectedCustomer;

  Customer get selectedCustomer => _selectedCustomer;

  set selectedCustomer(Customer value) {
    _selectedCustomer = value;
  }

  final StreamController<List<Customer>> _customers =
      StreamController<List<Customer>>.broadcast();

  getCustomers() async {
    List<Customer> response = await _bimby.getCustomers();
    _customers.sink.add(response);
  }

  dispose() {
    _customers?.close();
  }

  changeCategory(int index) {
    _customers.sink.add(null); //Clear news
    getCustomers();
  }

  BimbiBloc() {}
}
