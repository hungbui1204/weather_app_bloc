import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('Weather Today'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              'Hanoi (VN)',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clouds',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(' (overcast clouds)',
                    style: TextStyle(color: Colors.white))
              ],
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: LottieBuilder.network(
                'https://lottie.host/9a388e77-30b7-4e6d-90af-9d212380b3ab/jhffag9D9L.json',
                fit: BoxFit.fill,
                repeat: true,
              ),
            ),
            Text(
              'Update: ${DateTime.now()}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Temp: 30°C',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
