# BWA APP

### todo
- [ ] Menambahkan fitur login dari google
- [ ] Fix bug pada saat fullscreen video, terkadang ukuran tidak mempenuhi layar Menambahkan halaman kategori kelas ketika salah satu kategori kelas di klik pada halaman home
- [x] Bisa logout akun


# Persyaratan Sistem
- flutter SDK, versi yang digunakan pada projek ini versi 2.5.3
- android studio

# Stuktur kode
### folder : 
- assets: untuk menyimpan aset yang digunakan, berisi gambar, icon, dan logo
- lib: untuk menulis kode dart

### folder di dalam lib : 
- cubit: menyimpan file bloc state management 
- firebase: untuk menyimpan kode fungsi dari firebase
- helpers: untuk menyimpan kode class bantuan, atau fungsi yang digunakan berulang kali seperti string helper
- models: untuk menyimpan file model yang berguna untuk membawa data dari API atau database lokal
- repository: untuk menyimpan file kode penyimpanan data atau pengambilan data, seperti api
- shared: menyimpan file theme.dart
- ui : untuk menyimpan file yang akan ditampilkan ke user 

# instalasi
buka projek pada IDE yang digunakan,lakukan perintah 'flutter pub get' pada terminal

```sh
cd bwa_app
flutter pub get
```

# Penggunaan

## User
### User Login

kirim email dan password ke API melalui Bloc
```dart
context.read<AuthCubit>().signIn(
    email: emailController.text,
    password: passwordController.text,
);
```

lalu save data user di database lokal menggunakan package dari shared preferences
```dart
UserDB.saveUser(userData);
```

### Get Data User
ambil data melalui perintah dari Bloc
```dart
context.read<UserCubit>().getUser();
```

untuk menampilkan data user gunakan BlocBuilder
```dart
BlocBuilder<UserCubit, UserState>(
    builder: (context, state) {
        if (state is UserSuccess) {
            print(state.user.name);
            return Widget;
        }
        return SizedBox();
    },
  );
}
```

### remove User / Logout
hapus data user melalui perintah dari Bloc
```dart
context.read<UserCubit>().removeUser();
```

## course
### starter course
untuk hanya menampilkan beberapa kelas gunakan fungsi berikut
```dart
// hanya mengambil 2 kelas yang akan ditampilkan
int take = 2;

// untuk kelas free starter
context.read<FreeStarterCourseForHomeCubit>().getNewFreeCourse(take);

//untuk kelas top starter
context.read<TopStarterCourseForHomeCubit>().getTopFeatured(take);
```

Menampilkan semua kelas gunakan fungsi berikut
```dart
// untuk kelas free starter
context.read<FreeStarterCourseCubit>().getNewFreeCourse();

//untuk kelas top starter
context.read<TopStarterCourseCubit>().getTopFeatured();
```

Untuk mendapatkan data kelas gunakan BlocBuilder
```dart
// untuk free starter
BlocBuilder<FreeStarterCourseCubit, StarterCourseState>(
    builder: (context, state) {
        if (state is UserSuccess) {
            print(state.course.namaKelas);
            return Widget;
        }
        return SizedBox();
    },
  );
}

// untuk top starter
BlocBuilder<TopStarterCourseCubit, StarterCourseState>(
    builder: (context, state) {
        if (state is UserSuccess) {
            print(state.course.namaKelas);
            return Widget;
        }
        return SizedBox();
    },
  );
}
```

## Detail Course
untuk mendapatkan detail dari kelas gunakan fungsi
```dart
int idCourse = 123;

context.read<DetailCourseCubit>().getDetailCourse(idCourse);
```

untuk mendapatkan data dari detail kelas
```dart
BlocBuilder<DetailCourseCubit, DetailCourseState>(
    builder: (context, state) {
        if (state is UserSuccess) {
            print(state.course);
            return Widget;
        }
        return SizedBox();
    },
  );
}
```

## Search Course
untuk melakukan pencarian gunakan fungsi
```dart
String course = 'flutter';

context.read<SearchCourseCubit>().getSearchCourse(course);
```

untuk mendapatkan data dari pencarian kelas
```dart
BlocBuilder<SearchCourseCubit, SearchCourseState>(
    builder: (context, state) {
        if (state is UserSuccess) {
            print(state.course);
            return Widget;
        }
        return SizedBox();
    },
  );
}
```

## Package
package yang digunakan untuk projek ini

| Package | Link |
| ------ | ------ |
| cupertino_icons: ^1.0.2 | https://pub.dev/packages/cupertino_icons |
| equatable: ^2.0.3 | https://pub.dev/packages/equatable |
| firebase_core: ^1.7.0 | https://pub.dev/packages/firebase_core |
| firebase_crashlytics: ^2.2.3 | https://pub.dev/packages/firebase_crashlytics |
| flutter_bloc: ^7.3.3 | https://pub.dev/packages/flutter_bloc/score |
| flutter_html: ^2.1.4 | https://pub.dev/packages/flutter_html |
| flutter_inappwebview: ^5.3.2 | https://pub.dev/packages/flutter_inappwebview |
| flutter_launcher_icons: ^0.9.2 | https://pub.dev/packages/flutter_launcher_icons |
| google_fonts: ^2.1.0 | https://pub.dev/packages/google_fonts |
| http: ^0.13.3 | https://pub.dev/packages/http |
| oauth2_client: ^2.3.0 | https://pub.dev/packages/oauth2_client |
| shared_preferences: ^2.0.9 | https://pub.dev/packages/shared_preferences |
