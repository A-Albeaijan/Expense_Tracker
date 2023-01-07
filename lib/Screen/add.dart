import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../sql/db.dart';
import 'package:sqflite/sqflite.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    TextEditingController _title = TextEditingController();
    TextEditingController _amount = TextEditingController();

    String? _selectedValue;
    List<String> listOfValue = ['Food', 'Car', 'Home', 'Electricity', 'Other'];

    TextEditingController _date = TextEditingController();

    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: height * 0.15,
            color: const Color.fromARGB(255, 56, 182, 121),
            child: const Center(
              child: Text(
                'Add New Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 9,
          right: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            height: height * 0.65,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, bottom: 10),
                    child: TextFormField(
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
                      controller: _amount,
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
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, top: 30),
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
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
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
                        if (_selectedValue == 'Other') {
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, bottom: 10),
                            child: TextFormField(
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
                          );
                        }
                      },
                      onSaved: (value) {
                        _selectedValue = value.toString();
                        print(_selectedValue);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, top: 30),
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
                      controller: _date,
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
                          ;
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
                          //store data
                          DatabaseHelper.createItem(
                              _title.text,
                              _selectedValue!,
                              _date.text,
                              double.parse(_amount.text));

                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "Expense has been added successful",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (route) => false),
                                width: 120,
                              ),
                            ],
                          ).show();
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              ),
                            ],
                          ).show();
                        }
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
