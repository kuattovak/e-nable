import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HandControlPage extends StatefulWidget {
  @override
  _HandControlPageState createState() => _HandControlPageState();
}

class _HandControlPageState extends State<HandControlPage> {
  final List<double> _progressValues = List<double>.filled(5, 0.5);

  double get _meanPercentage {
    return _progressValues.reduce((a, b) => a + b) /
        _progressValues.length *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData.fallback(),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'Hand control',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color(0xff1F59DA), fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 100, top: 10, left: 16, right: 16),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildSlider(0, 180, 20),
                    _buildSlider(1, 326, 5),
                    _buildSlider(2, 313, 0),
                    _buildSlider(3, 326, 5),
                    _buildSlider(4, 281, 20),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        width: 198,
                        height: 197,
                        child: CircularProgressIndicator(
                          semanticsLabel: _meanPercentage.toString(),
                          color: Color(0xff1F59DA),
                          backgroundColor: Color(0XffE6EEFF),
                          value: _meanPercentage / 100,
                          strokeWidth: 15,
                          strokeCap: StrokeCap.round,
                        )),
                    Text(
                      '${_meanPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1F59DA),
                      ),
                    ),
                  ],
                ),
              ])),
        ));
  }

  Widget _buildSlider(int index, double height, double spaceHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: spaceHeight),
        Container(
          height: height,
          child: RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: Color(0xff1F59DA),
                activeTrackColor: Color(0xff1F59DA),
                inactiveTrackColor: Color(0XffE6EEFF),
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 12.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
              ),
              child: Slider(
                value: _progressValues[index],
                onChanged: (newValue) {
                  setState(() {
                    _progressValues[index] = newValue;
                  });
                },
                min: 0.0,
                max: 1.0,
                label: '${(_progressValues[index] * 100).toInt()}%',
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
