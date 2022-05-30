import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Positioning using Gyro Sensor',
      home: SensorDrivenImage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class SensorDrivenImage extends StatefulWidget {
  const SensorDrivenImage({Key? key}) : super(key: key);

  @override
  State<SensorDrivenImage> createState() => _SensorDrivenImageState();
}

class _SensorDrivenImageState extends State<SensorDrivenImage> {
  String imgUrl = 'assets/images/nature.jpg';
  double initX = 0;
  double initY = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Positioning Sensor'),
      ),
      body: Stack(
        children: [
          StreamBuilder<GyroscopeEvent>(
              stream: SensorsPlatform.instance.gyroscopeEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.y.abs() > 0)
                    initX = initX + snapshot.data!.y;

                  if (snapshot.data!.x.abs() > 0)
                    initY = initY + snapshot.data!.y;
                }
                return Positioned(
                  left: 10 - initX,
                  right: 10 + initX,
                  top: 10 - initY,
                  bottom: 10 + initY,
                  child: Center(
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              width: 230,
                              height: 330,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  isAntiAlias: true,
                                  opacity: 0.8,
                                  image: AssetImage(imgUrl),
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.1), BlendMode.srcOver),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 4,sigmaY: 4
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          Positioned(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
              child: Center(
                child: Container(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          width: 250,
                          height: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white, width: 0.1
                            ),
                            image: DecorationImage(
                              image: AssetImage(imgUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10)
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
