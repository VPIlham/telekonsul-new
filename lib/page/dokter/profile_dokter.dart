part of '../pages.dart';

class ProfileDokter extends StatefulWidget {
  @override
  _ProfileDokterState createState() => _ProfileDokterState();
}

class _ProfileDokterState extends State<ProfileDokter> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DokterProvider>(
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
                      onTap: () async => await _pickImage(value.dokter),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.grey,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile)
                            : value.dokter.profileUrl != "" && imageFile == null
                                ? NetworkImage(value.dokter.profileUrl)
                                : null,
                        child:
                            imageFile != null || value.dokter.profileUrl != ""
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
                              "Nama : ${value.dokter.nama}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Email : ${value.dokter.email}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Nomor HP : ${value.dokter.noTelp}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Alamat : ${value.dokter.alamat}",
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditProfileDokter(dokter: value.dokter),
                        ));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.deepOrange,
                      height: 40,
                      minWidth: 150,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          await FirebaseAuth.instance.currentUser.reload();
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .getUser(Provider.of<DokterProvider>(context,
                                  listen: false));
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
                        "Logout",
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

  _pickImage(Dokter dokter) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      await _cropImage();
      await _updatePhotoProfile(dokter);
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

  _updatePhotoProfile(Dokter dokter) async {
    try {
      final dataAuth = FirebaseAuth.instance;
      String fileName = imageFile.path.split("/").last;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Photo Profile/${dataAuth.currentUser.uid}/$fileName');

      final dataImage = await ref.putFile(imageFile);
      String photoPath = await dataImage.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .doc("dokter/${dataAuth.currentUser.uid}")
          .update(
        {
          'profile_url': photoPath,
        },
      );

      Dokter newData = dokter;
      newData.profileUrl = photoPath;
      Provider.of<DokterProvider>(context, listen: false).setDokter = newData;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
