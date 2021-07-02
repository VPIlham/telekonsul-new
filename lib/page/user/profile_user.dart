part of '../pages.dart';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (BuildContext context, value, Widget child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 56.0),
                  Center(
                    child: InkWell(
                      onTap: () async => await _pickImage(),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.grey,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile)
                            : value.user.profileUrl != "" && imageFile == null
                                ? NetworkImage(value.user.profileUrl)
                                : null,
                        child: imageFile != null || value.user.profileUrl != ""
                            ? null
                            : Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 86,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 56),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama : ${value.user.nama}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Email : ${value.user.email}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Nomor HP : ${value.user.noTelp}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Alamat : ${value.user.alamat}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 42),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          await FirebaseAuth.instance.currentUser.reload();
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .getUser(null);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Terjadi Kesalahan"),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                      height: 40,
                      minWidth: 150,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      await _cropImage();
      await _updatePhotoProfile();
      await Provider.of<UserProvider>(context, listen: false).getUser(null);
    }
    return;
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        imageFile = croppedFile;
      });
    }
  }

  _updatePhotoProfile() async {
    try {
      final dataAuth = FirebaseAuth.instance;
      String fileName = imageFile.path.split("/").last;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Photo Profile/${dataAuth.currentUser.uid}/$fileName');

      final dataImage = await ref.putFile(imageFile);
      String photoPath = await dataImage.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .doc("users/${dataAuth.currentUser.uid}")
          .update(
        {
          'profile_url': photoPath,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
