<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0F766E,0EA5E9&height=160&section=header&text=Bookia&fontSize=52&fontColor=ffffff&fontAlignY=42&desc=Flutter%20E-Commerce%20Bookstore%20App&descAlignY=62&descSize=18&animation=fadeIn" width="100%"/>

</div>

---

## 📖 Overview

**Bookia** is a production-quality Flutter e-commerce app for discovering and purchasing books. Built with a **feature-first architecture**, **Bloc/Cubit** state management, and a real **REST API** backend

---

## ✨ Features

### 🔐 Authentication
- User registration & login
- Forget password with OTP verification
- Create new password flow
- Session management with secure token handling

### 🏠 Home
- Dynamic featured book sliders
- Best sellers section
- Smooth and responsive UI

### 📖 Book Details
- Full book info — title, description, author, price, cover image
- Add to cart or wishlist directly from details

### 🛒 Cart
- Add / remove books
- Checkout flow with order confirmation

### ❤️ Wishlist
- Save and manage favorite books
- Persisted across sessions

### 🔍 Search
- Search books by title

### 👤 Profile
- View and manage user information

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| UI | Flutter (Dart) |
| State Management | Bloc / Cubit |
| Networking | Dio + REST APIs |
| Architecture | Feature-first layered architecture (cubit / data / ui) |

---

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── helper/
│   │   ├── bloc_observer.dart
│   │   ├── error_handler.dart
│   │   ├── extensions.dart
│   │   └── storage_services.dart
│   ├── networking/
│   │   ├── api_constants.dart
│   │   ├── api_result.dart
│   │   ├── api_result.freezed.dart
│   │   └── dio_factory.dart
│   ├── routes/
│   │   ├── app_routers.dart
│   │   └── app_routes.dart
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── auth/
│   │   ├── cubit/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repo/
│   │   └── ui/
│   │       └── widgets/
│   ├── home/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── book_details/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── cart/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── wishlist/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── search/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── profile/
│   │   ├── cubit/
│   │   ├── data/
│   │   └── ui/
│   ├── book_mark/
│   └── bottom_nav_bar/
│
├── bookia_app.dart
└── main.dart
```

---

## 📸 Screenshots

# Logo App
<img width="63" height="84" alt="image" src="https://github.com/user-attachments/assets/eec4c2ff-2821-4a9e-a9ed-c86dde528204" />

# OnBoarding Screen
<img width="425" height="844" alt="image" src="https://github.com/user-attachments/assets/0e6b8034-df0f-4fdd-91df-67d0c6f7b2e7" />

# Login Screen
<img width="425" height="838" alt="image" src="https://github.com/user-attachments/assets/8e1b7d7d-308b-4e2b-bae4-fd2681cdd06b" />

# regisger Screen
<img width="346" height="759" alt="image" src="https://github.com/user-attachments/assets/b3fec3b6-9b5d-42bc-aabf-9861e1847df1" />

# Forget Password Screen 
<img width="330" height="728" alt="image" src="https://github.com/user-attachments/assets/63a0e464-7f28-44d1-9067-486bd875f7a1" />

# Otp Verfication Screen
<img width="338" height="749" alt="image" src="https://github.com/user-attachments/assets/ec8b844b-433b-41cc-a11c-08d861f3ece7" />

# Create a new password 
<img width="362" height="758" alt="image" src="https://github.com/user-attachments/assets/79ba1e06-0535-47c3-9f71-e47fd5629df1" />

# Password Changed successfully
<img width="352" height="767" alt="image" src="https://github.com/user-attachments/assets/09e2eda2-357c-4c1b-959d-85140ea99605" />

# Home 
<img width="307" height="628" alt="Image" src="https://github.com/user-attachments/assets/9dedebfc-556f-4125-9223-b3d29d592a2b" />

# book Details 
<img width="292" height="626" alt="Image" src="https://github.com/user-attachments/assets/947c3c44-1c4c-4869-9466-5f07eca96a06" />

# Search Screen
<img width="298" height="623" alt="Image" src="https://github.com/user-attachments/assets/b20433c9-b7e0-42ac-903c-e36a43a4a05a" />

# Cart Screen 
<img width="333" height="734" alt="image" src="https://github.com/user-attachments/assets/1d8203a3-71a8-434c-9047-8d219066db75" />

# CheckOut Screen
<img width="315" height="668" alt="image" src="https://github.com/user-attachments/assets/cf8a03cf-e2dc-4de0-baac-f9d6d205fb3d" />

# Congrats Screen 
<img width="293" height="628" alt="image" src="https://github.com/user-attachments/assets/f59211d7-14c0-495d-95b1-fe2579c9279e" />

# Wishlist Screen
<img width="332" height="735" alt="image" src="https://github.com/user-attachments/assets/20858f73-9b3d-4d5d-9331-b1243da59ae4" />

# profile screen
<img width="341" height="735" alt="image" src="https://github.com/user-attachments/assets/ae8641be-490e-4541-bc4f-48ae874ffed5" />

---

## ⚙️ Getting Started

### Prerequisites
- Flutter SDK (3.x+)
- Android Studio or VS Code
- Android emulator or physical device

### Installation

```bash
git clone https://github.com/Anas3Ezz/bookia.git
cd bookia
flutter pub get
flutter run
```
To run this project:
1. Create a Firebase project
2. Run: flutterfire configure
3. Add google-services.json to android/app
---

## 🔮 Planned Improvements

- [ ] Payment gateway integration
- [ ] Advanced search with filters & categories
- [ ] Reviews & ratings system
- [ ] Unit & widget tests
- [ ] Dark mode 🌙

---

## 👨‍💻 Author

**Anas Ezz** — Flutter Developer 🇪🇬

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/YOUR_LINKEDIN_HANDLE)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/Anas3Ezz)

---
\div>
