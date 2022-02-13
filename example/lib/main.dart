import 'package:country_dial_code/country_dial_code.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country dial code'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.all(10.0),

                /// Example of the use the country dial code picker.
                prefixIcon: CountryDialCodePicker(
                  initialSelection: 'US',
                  flagImageSettings: FlagImageSettings(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  bottomSheetSettings: BottomSheetSettings(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    searchTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  onChanged: (value) {
                    print(value.dialCode);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
