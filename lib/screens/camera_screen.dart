import 'package:alcohol_tracker/screens/image_preview_screen.dart';
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
  bool takingPicture = false;

  @override //is supposed to dispose the camera when closing app without leaving camera screen
  Future<void> didChangeAppLifeCycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      dispose();
    } else if (state == AppLifecycleState.resumed) {
      _task = cameraSetup();
    }
  }

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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: takingPicture
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 8,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                takingPicture = true;
                              });
                            },
                            child: IconButton(
                              onPressed: () async {
                                if (!_controller.value.isInitialized) {
                                  return;
                                }
                                if (_controller.value.isTakingPicture) {
                                  return;
                                } else {
                                  setState(() {
                                    takingPicture = false;
                                  });
                                }

                                try {
                                  await _controller.setFlashMode(FlashMode.off);

                                  //Makes it much faster
                                  await _controller
                                      .setFocusMode(FocusMode.locked);

                                  XFile picture =
                                      await _controller.takePicture();

                                  //Makes it much faster
                                  await _controller
                                      .setFocusMode(FocusMode.locked);

                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImagePreviewScreen(
                                                  file: picture)));
                                } on CameraException catch (e) {
                                  debugPrint(
                                      "Error occured while taking picture: $e");
                                  return;
                                }
                              },
                              icon: const Icon(
                                Icons.circle_outlined,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
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
        selectedIndex: 3,
      ),
    );
  }

  Future<bool> cameraSetup() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    _controller =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);

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
