import 'package:flutter/material.dart';



class FilterSliderBar extends StatefulWidget {
  @override
  _FilterSliderBarState createState() => _FilterSliderBarState();
}

class _FilterSliderBarState extends State<FilterSliderBar> {
  double _lowerValue = 20;
  double _upperValue = 80;

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
    
      body:
       Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSlider(
                values: RangeValues(_lowerValue, _upperValue),
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (RangeValues values) {
                  setState(() {
                    _lowerValue = values.start;
                    _upperValue = values.end;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Selected Range: $_lowerValue - $_upperValue',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
