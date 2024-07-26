# Diamond Store Project Flutter

## Author
TechLineSolutions.id Mobile Team

## Date
26 July 2024

## Project Description
Bank Sampah


## Getting started

**Prerequisites :**

- Flutter SDK : 3.22.1
- IDE of your choice (e.g., VS Code, or Android Studio)

- add in dev_dependencies
  - build_runner: ^2.4.11
  - flutter_gen_runner: ^5.5.0+1

- when you add image static or icon just run 
   - dart run build_runner build

**Installation :**

1. Clone the repository
`git clone `https://github.com/Galuhdap/rebuild-banksampah`
2. Navigate to project directory
`cd rebuild-banksampah`
3. Install Dependencies
`flutter pub get`

**Running the Application :**
1. Connect a device or emulator
2. Run the app `flutter run`

**Launch Settings**

1. **VS Code**

        {
            "name": "Bank Sampah",
            "type": "dart",
            "request": "launch",
            "program": "lib/main_prod.dart",
            "args": [
                "--flavor",
                "prod"
               
            ]
        },      
        {
            "name": "Dev Bank Sampah",
            "type": "dart",
            "request": "launch",
            "program": "lib/main_dev.dart",
            "args": [
                "--flavor",
                "dev"
               
            ]
        }

2. **Android Studio**

`--flavor prod --no-enable-impeller`