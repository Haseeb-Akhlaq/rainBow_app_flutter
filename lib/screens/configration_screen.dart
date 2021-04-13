import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ConfigrationScreen extends StatefulWidget {
  final Function musicChange;
  final Function selectSongFromDevice;

  const ConfigrationScreen({
    this.musicChange,
    this.selectSongFromDevice,
  });

  @override
  _ConfigrationScreenState createState() => _ConfigrationScreenState();
}

class _ConfigrationScreenState extends State<ConfigrationScreen> {
  int selectedSound = 0;
  bool selectSongFromDevice = false;
  String songName = '';

  Future<String> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null) return null;
    print(result.files.single.path);
    return result.files.single.path;
  }

  @override
  void initState() {
    super.initState();
    print(selectSongFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configration Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Sound :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      onChanged: (v) {
                        setState(() {
                          selectedSound = v;
                        });
                      },
                      value: selectedSound,
                      items: [
                        DropdownMenuItem(
                          child: Text('Default'),
                          value: 0,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text('OR'),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    TextButton.icon(
                      label: Text('Select From Phone'),
                      icon: Icon(
                        Icons.cloud_download_outlined,
                      ),
                      onPressed: () async {
                        final songPath = await pickVideoFile();
                        if (songPath == null) {
                          return;
                        }
                        setState(() {
                          songName = songPath.split('/file_picker/')[1];
                        });
                        selectSongFromDevice = true;
                        widget.selectSongFromDevice(
                            songPath, selectSongFromDevice);
                      },
                    ),
                    Text(songName),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (selectSongFromDevice == true) {
                  Navigator.pop(context);
                } else {
                  widget.musicChange(selectedSound);
                  Navigator.pop(context);
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
