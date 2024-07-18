import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/screens/handcontrol/hand_control_page.dart';
import 'package:flutter_application_1/screens/progress/progress_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'E-nable',
          style: GoogleFonts.montserrat(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xff1F59DA)),
        ),
      ),
      backgroundColor: Color(0xffF8F8F8),
      body: Padding(
          padding: EdgeInsets.only(left: 53, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Welcome to',
                  style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                TextSpan(
                  text: ' E-nable',
                  style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1F59DA)),
                )
              ])),

              Text(
                'Check your states',
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  homeContainer('Start training', 'assets/barbell.svg', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HandControlPage()));
                  }),
                  homeContainer('Check your state', 'assets/check.svg', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressPage()));
                  })
                ],
              ),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    width: 291,
                    height: 123,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff1F59DA))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/temperature.svg',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Temperature',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff7F7F7F),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    '36.6 C',
                                    style: TextStyle(
                                        color: Color(0xff1F59DA),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: 217,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(32, 0, 0, 0))),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/pulse.svg',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pulse',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff7F7F7F),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    '85 BPM',
                                    style: TextStyle(
                                        color: Color(0xff1F59DA),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Text(
                'Your recent progress:',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              CalendarDate(
                dateDay: 2,
                dateMonth: 'June',
                dateYear: 2024,
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 316,
                    height: 29,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff1F59DA),
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      value: 50 / 100,
                      minHeight: 29,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 50,
                    child: Center(
                      child: Text(
                        '50%',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255,
                              255), // Adjust the text color as needed
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )

              //          const LinearProgressIndicator(

              //     backgroundColor: Color.fromARGB(255, 220, 220, 220),
              //     valueColor: AlwaysStoppedAnimation<Color>( Color(0xff1F59DA),),  // Placeholder color
              //     value: 0.5,  // Placeholder value (from 0.0 to 1.0)
              //     minHeight: 25,

              // )
            ],
          )),
    );
  }

  Widget homeContainer(String text, String icon, Function() onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Container(
                width: 134,
                height: 123,
                decoration: BoxDecoration(
                    color: Color(0xff1F59DA),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(icon),
                        SizedBox(
                            width: 80,
                            child: Text(
                              text,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    )))));
  }
}

class CalendarDate extends StatelessWidget {
  final int dateDay;
  final String dateMonth;
  final int dateYear;
  const CalendarDate(
      {super.key,
      required this.dateDay,
      required this.dateMonth,
      required this.dateYear});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 36,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff1F59DA), Color(0xff06A5FF)]),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Text('$dateDay $dateMonth | $dateYear',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 255, 255, 255)))),
    );
  }
}
