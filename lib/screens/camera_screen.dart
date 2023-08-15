import 'package:alcohol_tracker/screens/take_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    _task = cameraSetup();
  }

  late Future<bool> _task;
  late CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _task,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.

          SchedulerBinding.instance.addPostFrameCallback((_) {
            // add your code here.

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TakePictureScreen(controller: _controller)));
          });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<bool> cameraSetup() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return true;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case "CameraAccessDenied":
            print("Access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
      return false;
    });
    return false;
  }
}
