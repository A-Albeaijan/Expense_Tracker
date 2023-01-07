import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personal_experience/Widget/hoempage_button.dart';
import 'package:personal_experience/sql/db.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class exList extends StatefulWidget {
  const exList({super.key, required this.height});
  final double height;
  @override
  State<exList> createState() => _exListState(height);
}

class _exListState extends State<exList> {
  final date = DateTime.now();
  final double height;
  List<Map<String, dynamic>> _list = [];
  final day = DateTime.now().day;
  final month = DateTime.now().month;
  double _amount = 0;
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      _list = data;
      _list.forEach((element) {
        _amount += element['amount'];
      });
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  _exListState(this.height);

  @override
  Widget build(BuildContext context) {
    String image;

    return Container(
      height: height * 0.58,
      child: Column(
        children: [
          // HomepageButton(height: height),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                DateFormat.yMMMMd().format(date as dynamic),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_amount} SR',
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: _list.isEmpty == true
                  ? Center(
                      child: const Text(
                        'No expense has been added yet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: ((context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[300],
                          )),
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(
                                    () {
                                      DatabaseHelper.deleteItem(
                                          _list[index]['id']);
                                      _amount =
                                          _amount - _list[index]['amount'];
                                      _list = List.from(_list)..removeAt(index);
                                    },
                                  );
                                },
                                borderRadius: BorderRadius.circular(10),
                                backgroundColor: Colors.redAccent,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              // SlidableAction(
                              //   borderRadius: BorderRadius.circular(10),
                              //   onPressed: (context) {
                              //     showModalBottomSheet<void>(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return SingleChildScrollView(
                              //           child: Container(
                              //             padding: EdgeInsets.all(10),
                              //             margin: EdgeInsets.all(10),
                              //             height: height * 0.8,
                              //             child: Center(
                              //               child: edit(index),
                              //             ),
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              //   backgroundColor: Colors.green,
                              //   icon: Icons.edit,
                              //   label: 'Edit',
                              // ),
                            ],
                          ),
                          child: ListTile(
                            subtitle: Text(_list[index]['date']),
                            leading: CircleAvatar(
                              child: _list[index]['type'] != 'Other'
                                  ? Image.asset(
                                      'assets/images/${_list[index]['type']}.png')
                                  : const Text('Other'),
                            ),
                            title: Text(
                              _list[index]['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              '${_list[index]['amount'].toString()} SR',
                              style: TextStyle(
                                color: Colors.orange[600],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _amountinput = TextEditingController();

  String? _selectedValue;
  List<String> listOfValue = ['Food', 'Car', 'Home', 'Electricity', 'Other'];

  TextEditingController _date = TextEditingController();

  Widget edit(int index) {
    _title.text = _list[index]['title'];
    _amountinput.text = _list[index]['amount'].toString();
    _selectedValue = _list[index]['type'];
    _date.text = _list[index]['date'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
                child: TextFormField(
                  initialValue: _title.text,
                  controller: _title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  maxLength: 30,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: TextFormField(
                  initialValue: _amountinput.text,
                  controller: _amountinput,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    } else if (double.tryParse(value) == false) {
                      return 'Please enter a number';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a positive amount';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Amount in SR',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: listOfValue
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              //add icon
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                  },
                  onChanged: (value) {
                    _selectedValue = value.toString();
                  },
                  onSaved: (value) {
                    _selectedValue = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Select date'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  initialValue: _list[index]['date'],
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050));

                    if (pickedDate != null) {
                      _date.text = DateFormat('yyyy-MM-dd')
                          .format(pickedDate)
                          .toString();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 23, 69, 92),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(100, 30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //update data
                      DatabaseHelper.updateItem(
                          _list[index]['id'],
                          _title.text,
                          _selectedValue!,
                          _date.text,
                          double.parse(_amountinput.text));
                    }
                    //popup message

                    else {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Something went wrong",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Done",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          ),
                        ],
                      ).show();
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
