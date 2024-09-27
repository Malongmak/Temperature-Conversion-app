import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      home: const TemperatureConverter(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  final List<String> _history = [];
  String _conversionType = 'FtoC';

  void _convertTemperature() {
    double? inputTemperature = double.tryParse(_controller.text);
    if (inputTemperature == null) {
      setState(() {
        _result = 'Please enter a valid number.';
      });
      return;
    }

    double convertedTemperature;
    if (_conversionType == 'FtoC') {
      convertedTemperature = (inputTemperature - 32) * (5 / 9);
      _result =
          '${inputTemperature.toStringAsFixed(1)} °F => ${convertedTemperature.toStringAsFixed(2)} °C';
      _history.add(
          'F to C: ${inputTemperature.toStringAsFixed(1)} => ${convertedTemperature.toStringAsFixed(2)}');
    } else {
      convertedTemperature = (inputTemperature * (9 / 5)) + 32;
      _result =
          '${inputTemperature.toStringAsFixed(1)} °C => ${convertedTemperature.toStringAsFixed(2)} °F';
      _history.add(
          'C to F: ${inputTemperature.toStringAsFixed(1)} => ${convertedTemperature.toStringAsFixed(2)}');
    }

    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'FtoC',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    const Text('F to C'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'CtoF',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    const Text('C to F'),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
