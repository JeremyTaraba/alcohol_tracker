import 'package:alcohol_tracker/util/bottom_nav.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    //closes the camera when leaving the screen
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _task,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  child: CameraPreview(_controller),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () async {
                      if (!_controller.value.isInitialized) {
                        return null;
                      }
                      if (_controller.value.isTakingPicture) {
                        return null;
                      }
                      try {
                        await _controller.setFlashMode(FlashMode.auto);
                        XFile picture = await _controller.takePicture();
                      } on CameraException catch (e) {
                        debugPrint("Error occured while taking picture: $e");
                        return null;
                      }
                    },
                    icon: Icon(
                      Icons.circle_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: bottomNav(
        selectedIndex: 4,
      ),
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
