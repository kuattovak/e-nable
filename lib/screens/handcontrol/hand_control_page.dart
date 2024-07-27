import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HandControlPage extends StatefulWidget {
  @override
  _HandControlPageState createState() => _HandControlPageState();
}

class _HandControlPageState extends State<HandControlPage> {
  TextEditingController ipAddressText = TextEditingController();
  String ipAddress = '';
  bool ipSubmitted = false; // Track if IP address has been submitted
  final List<double> _progressValues =
      List<double>.filled(5, 0.0); // Start from 0.0
  bool paused = false; // Track if controls are paused

  double get _meanPercentage {
    return _progressValues.reduce((a, b) => a + b) /
        _progressValues.length *
        100;
  }

  void updateServo(int id, double value, String ipAddress) async {
    int servoValue = (value * 100).toInt(); // Adjust as per your servo range

    // Send HTTP request to update servo position
    var url = Uri.parse('http://$ipAddress/flex$id&value=$servoValue');

    var response = await http.get(url);
    if (response.statusCode != 200) {
      print('Failed to update servo $id');
    }
  }

  void sendData() async {
    for (int i = 0; i < _progressValues.length; i++) {
      updateServo(i + 1, _progressValues[i], ipAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext context) => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 30),
                          child: Text('IP-Address: $ipAddress'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Type IP-Address',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xff1F59DA)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 214, 214, 214)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 221, 221, 221)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: ipAddressText,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 53),
                          child: Row(
                            children: [
                              handControlButton('Submit', Color(0xff1F59DA),
                                  () {
                                setState(() {
                                  ipAddress = ipAddressText.text;
                                  ipSubmitted = true;
                                  paused =
                                      false; // Ensure controls are not paused
                                  Navigator.pop(
                                      context); // Close the bottom sheet after submitting
                                });
                              }),
                              SizedBox(width: 20),
                              handControlButton(
                                  'Edit', Color.fromARGB(255, 50, 218, 31), () {
                                setState(() {
                                  ipAddress = ipAddressText.text;
                                  ipSubmitted = true;
                                  Navigator.pop(
                                      context); // Close the bottom sheet after editing
                                });
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text(
                'Set IP Address',
                style: TextStyle(
                  color: Color(0xff1F59DA),
                ),
              ))
        ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
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
          padding:
              const EdgeInsets.only(bottom: 100, top: 10, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildSlider(0, 1, 180, 146),
                  _buildSlider(1, 2, 326, 15),
                  _buildSlider(2, 3, 313, 0),
                  _buildSlider(3, 4, 326, 15),
                  _buildSlider(4, 5, 281, 32),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      semanticsLabel: _meanPercentage.toString(),
                      value: _meanPercentage / 100,
                      strokeWidth: 15,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Color(0XffE6EEFF),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff1F59DA)),
                    ),
                  ),
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    handControlButton(
                        'Send Data', Color.fromARGB(255, 95, 233, 99), () {
                      if (ipSubmitted && !paused) {
                        sendData();
                      }
                    }),
                    SizedBox(width: 20),
                    handControlButton('Pause',
                        paused ? Colors.grey : Color.fromARGB(255, 255, 50, 50),
                        () {
                      setState(() {
                        paused = !paused; // Toggle paused state
                      });
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget handControlButton(String title, Color color, Function() onTap) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
      int index, int servoId, double spaceHeight, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
        ),
        SizedBox(
          height: spaceHeight,
          child: Container(
            height: 220,
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
                  onChanged: (ipSubmitted && !paused)
                      ? (newValue) {
                          setState(() {
                            _progressValues[index] = newValue;
                          });
                        }
                      : null, // Disable the slider if not allowed to drag

                  min: 0.0,
                  max: 1.0,
                  divisions: 100, // This makes the slider more precise
                  label: (_progressValues[index] * 100)
                      .toStringAsFixed(1), // Show precise value
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
