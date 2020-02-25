import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  runApp(f4());
}

class f4 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget{
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imagefile;
  Future<void> _pickImage(ImageSource source) async{
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imagefile = selected;
    });
  }

  void _clear(){
    setState(() {
      _imagefile = null;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                }),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                }
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if(_imagefile != null) ...[
            Image.file(_imagefile),
            Row(
              children: <Widget>[
                FlatButton(onPressed: _clear, child: Icon(Icons.clear)),
              ],
            ),

            Uploader(file: _imagefile),
          ]
        ],
      ),

    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();

}
class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://database-firebase-1edb4.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {

    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(

              children: [
                if (_uploadTask.isComplete)
                  Text('🎉🎉🎉'),


                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                ),
              ],
            );
          });


    } else {

      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );

    }
  }
}