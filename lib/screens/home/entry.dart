import 'package:flutter/material.dart';
import 'package:new_money/services/database.dart';

class DataEntryScreen extends StatefulWidget {
  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());
  bool _isAllFieldsFilled =
      true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Electricity Uses in kW \n Last 7 Day\'s',
            style: TextStyle(fontSize: 16)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    width: 100,
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Day ${index + 1}'),
                    ),
                  ),
                );
              },
            ),
          ),
          if (!_isAllFieldsFilled) // Check if the flag is false
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please fill all the fields',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isAllFieldsFilled =
                controllers.every((controller) => controller.text.isNotEmpty);
          });

          if (_isAllFieldsFilled) {
            final newData =
                await controllers.map((controller) => controller.text).toList();
            await Service().addSevenDaysData(newData);
            Navigator.pop(context, newData);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
