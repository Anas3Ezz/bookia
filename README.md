# 📚 Bookia

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0F766E,0EA5E9&height=160&section=header&text=Bookia&fontSize=52&fontColor=ffffff&fontAlignY=42&desc=Flutter%20E-Commerce%20Bookstore%20App&descAlignY=62&descSize=18&animation=fadeIn" width="100%"/>

</div>

A production-quality Flutter e-commerce bookstore app built with clean architecture, Bloc/Cubit state management, and a fully themed UI supporting light and dark modes.

---

## 🎥 Demo

[▶️ Watch the demo on YouTube](https://youtube.com/shorts/RQzqTt0c2ZE?si=0CYLbs7lxCWcNs7P)

---

## ✨ Features

- Browse books with a dynamic home feed and slider carousel
- Book details with description, pricing, and discount display
- Add to cart and manage quantities
- Wishlist with sync banner
- Place order with full form validation
- User authentication (login, register, forgot password, OTP, reset password)
- Profile management with edit profile and order history
- Search with skeleton loading and empty/error states
- Dark / Light mode with persisted preference (Hive)
- Firebase integration

---

## 📸 Screenshots

### 🔐 Onboarding & Authentication

<table align="center">
  <tr>
    <th align="center">Splash</th>
    <th align="center">Login</th>
    <th align="center">Register</th>
  </tr>
  <tr>
    <td align="center"><img width="200" alt="Splash" src="https://github.com/user-attachments/assets/0e6b8034-df0f-4fdd-91df-67d0c6f7b2e7" /></td>
    <td align="center"><img width="200" alt="Login" src="https://github.com/user-attachments/assets/8e1b7d7d-308b-4e2b-bae4-fd2681cdd06b" /></td>
    <td align="center"><img width="200" alt="Register" src="https://github.com/user-attachments/assets/b3fec3b6-9b5d-42bc-aabf-9861e1847df1" /></td>
  </tr>
</table>

### 🔑 Password Recovery

<table align="center">
  <tr>
    <th align="center">Forgot Password</th>
    <th align="center">OTP Verification</th>
    <th align="center">Create New Password</th>
    <th align="center">Password Changed</th>
  </tr>
  <tr>
    <td align="center"><img width="200" alt="Forgot Password" src="https://github.com/user-attachments/assets/63a0e464-7f28-44d1-9067-486bd875f7a1" /></td>
    <td align="center"><img width="200" alt="OTP Verification" src="https://github.com/user-attachments/assets/ec8b844b-433b-41cc-a11c-08d861f3ece7" /></td>
    <td align="center"><img width="200" alt="Create New Password" src="https://github.com/user-attachments/assets/79ba1e06-0535-47c3-9f71-e47fd5629df1" /></td>
    <td align="center"><img width="200" alt="Password Changed" src="https://github.com/user-attachments/assets/09e2eda2-357c-4c1b-959d-85140ea99605" /></td>
  </tr>
</table>

### 🛍️ Browse & Shop

<table align="center">
  <tr>
    <th align="center">Home</th>
    <th align="center">Book Details</th>
    <th align="center">Search</th>
    <th align="center">Cart</th>
  </tr>
  <tr>
    <td align="center"><img width="200" alt="Home" src="https://github.com/user-attachments/assets/9dedebfc-556f-4125-9223-b3d29d592a2b" /></td>
    <td align="center"><img width="200" alt="Book Details" src="https://github.com/user-attachments/assets/947c3c44-1c4c-4869-9466-5f07eca96a06" /></td>
    <td align="center"><img width="200" alt="Search" src="https://github.com/user-attachments/assets/b20433c9-b7e0-42ac-903c-e36a43a4a05a" /></td>
    <td align="center"><img width="200" alt="Cart" src="https://github.com/user-attachments/assets/1d8203a3-71a8-434c-9047-8d219066db75" /></td>
  </tr>
</table>

### 📦 Checkout & Account

<table align="center">
  <tr>
    <th align="center">Checkout</th>
    <th align="center">Order Confirmed</th>
    <th align="center">Wishlist</th>
    <th align="center">Profile</th>
  </tr>
  <tr>
    <td align="center"><img width="200" alt="Checkout" src="https://github.com/user-attachments/assets/cf8a03cf-e2dc-4de0-baac-f9d6d205fb3d" /></td>
    <td align="center"><img width="200" alt="Order Confirmed" src="https://github.com/user-attachments/assets/f59211d7-14c0-495d-95b1-fe2579c9279e" /></td>
    <td align="center"><img width="200" alt="Wishlist" src="https://github.com/user-attachments/assets/20858f73-9b3d-4d5d-9331-b1243da59ae4" /></td>
    <td align="center"><img width="200" alt="Profile" src="https://github.com/user-attachments/assets/ae8641be-490e-4541-bc4f-48ae874ffed5" /></td>
  </tr>
</table>

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| State Management | `flutter_bloc` (Cubit) |
| Networking | `dio` + `Freezed` sealed `ApiResult<T>` |
| Local Storage | `Hive` (theme, token) |
| Authentication | Firebase Auth + custom REST API |
| Image Loading | `cached_network_image` |
| Navigation | Named routes with `onGenerateRoute` |
| Theming | `ThemeExtension` (`AppColorScheme`) + Hive persistence |
| Code Generation | `freezed`, `json_serializable`, `flutter_gen` |
| UI Utilities | `flutter_screenutil`, `gap`, `flutter_svg` |

---

## 🏗️ Architecture

This project follows **Feature-based Clean Architecture** with a clear separation between data, domain, and UI layers.

<details>
<summary><b>📂 Click to expand the project structure</b></summary>

```
lib/
├── core/
│   ├── helper/
│   │   ├── bloc_observer.dart
│   │   ├── error_handler.dart
│   │   ├── extenstions.dart
│   │   ├── storage_services.dart
│   │   └── validators.dart
│   ├── networking/
│   │   ├── api_constants.dart
│   │   ├── api_result.dart
│   │   ├── api_result.freezed.dart
│   │   ├── dio_factory.dart
│   │   └── fire_store_service.dart
│   ├── routs/
│   │   ├── app_routers.dart
│   │   └── app_routs.dart
│   ├── theme/
│   │   ├── cubit/
│   │   │   ├── theme_cubit.dart
│   │   │   └── theme_state.dart
│   │   ├── data/
│   │   │   ├── app_color_scheme.dart
│   │   │   ├── theme_local_data_source.dart
│   │   │   └── app_colors.dart
│   │   ├── app_texts_styles.dart
│   │   └── app_theme.dart
│   └── widgets/
│       ├── cashed_images.dart
│       ├── custom_app_bar.dart
│       ├── custom_app_button.dart
│       ├── custom_back_button.dart
│       └── custom_textform.dart
│
├── feature/
│   ├── auth/
│   │   ├── cubit/
│   │   │   ├── auth_cubit.dart
│   │   │   └── auth_state.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repo/
│   │   │       ├── auth_repo.dart
│   │   │       └── firebase_auth_repo.dart
│   │   └── ui/
│   │       ├── forgot_password/
│   │       │   ├── create_new_password.dart
│   │       │   ├── forget_password_screen.dart
│   │       │   ├── otp_verfication_screen.dart
│   │       │   └── password_changed_screen.dart
│   │       ├── widgets/
│   │       │   └── social_login_button.dart
│   │       ├── login_screen.dart
│   │       └── register_screen.dart
│   │
│   ├── home/
│   │   ├── cubit/
│   │   │   ├── home_cubit.dart
│   │   │   └── home_state.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── book_details_arg.dart
│   │   │   │   ├── books_model.dart
│   │   │   │   └── book_slider_model.dart
│   │   │   └── repo/
│   │   │       └── home_slider_repo.dart
│   │   └── ui/
│   │       ├── book_details/
│   │       │   ├── widgets/
│   │       │   │   ├── book_cover_image.dart
│   │       │   │   ├── book_description.dart
│   │       │   │   ├── book_details_appbar.dart
│   │       │   │   ├── book_title.dart
│   │       │   │   └── bottom_action_bar.dart
│   │       │   └── book_details_screen.dart
│   │       ├── widgets/
│   │       │   ├── best_seller_grid.dart
│   │       │   ├── best_seller_header.dart
│   │       │   ├── best_seller_skeleton_grid.dart
│   │       │   ├── book_card.dart
│   │       │   ├── slider_carousel.dart
│   │       │   ├── slider_indicator.dart
│   │       │   ├── section_header.dart
│   │       │   └── slider_skeleton.dart
│   │       └── home_screen.dart
│   │
│   ├── cart/
│   │   ├── cubit/
│   │   │   ├── cart_cubit.dart
│   │   │   └── cart_state.dart
│   │   ├── data/
│   │   │   ├── model/
│   │   │   │   └── add_to_cart_model.dart
│   │   │   └── repo/
│   │   │       └── add_to_cart_repo.dart
│   │   └── ui/
│   │       ├── widgets/
│   │       │   ├── cart_checkout_bar.dart
│   │       │   ├── cart_content.dart
│   │       │   ├── cart_empty.dart
│   │       │   ├── cart_error.dart
│   │       │   ├── cart_item_card.dart
│   │       │   ├── cart_skeleton_list.dart
│   │       │   └── quantity_controls.dart
│   │       ├── cart_screen.dart
│   │       ├── congrates_screen.dart
│   │       └── place_order_screen.dart
│   │
│   ├── wishlist/
│   │   ├── cubit/
│   │   │   ├── wishlist_cubit.dart
│   │   │   └── wishlist_state.dart
│   │   ├── data/
│   │   │   ├── model/
│   │   │   │   └── wishlist_model.dart
│   │   │   └── repo/
│   │   │       └── wishlist_repo.dart
│   │   └── ui/
│   │       ├── widgets/
│   │       │   ├── wishlist_empty.dart
│   │       │   ├── wishlist_error.dart
│   │       │   ├── wishlist_grid.dart
│   │       │   ├── wishlist_item_card.dart
│   │       │   ├── wishlist_skeleton_grid.dart
│   │       │   └── wishlist_sync_banner.dart
│   │       └── wishlist_screen.dart
│   │
│   ├── profile/
│   │   ├── cubit/
│   │   │   ├── profile_cubit.dart
│   │   │   └── profile_state.dart
│   │   ├── data/
│   │   │   ├── model/
│   │   │   │   └── profile_model.dart
│   │   │   └── repo/
│   │   │       └── profile_repo.dart
│   │   └── ui/
│   │       ├── widgets/
│   │       │   ├── profile_appbar.dart
│   │       │   ├── profile_error.dart
│   │       │   ├── profile_header.dart
│   │       │   ├── profile_image_widget.dart
│   │       │   ├── profile_menu.dart
│   │       │   ├── profile_menu_item.dart
│   │       │   └── profile_skeleton.dart
│   │       ├── new_password_screen.dart
│   │       ├── order_history_screen.dart
│   │       ├── profile_screen.dart
│   │       └── update_profile_screen.dart
│   │
│   └── search/
│       ├── cubit/
│       │   ├── search_cubit.dart
│       │   └── search_state.dart
│       ├── data/
│       │   ├── model/
│       │   │   └── search_args.dart
│       │   └── repo/
│       │       └── search_repo.dart
│       └── ui/
│           ├── widgets/
│           │   ├── search_empty_results.dart
│           │   ├── search_error_view.dart
│           │   ├── search_field.dart
│           │   ├── search_prompt.dart
│           │   ├── search_results_grid.dart
│           │   └── search_skeleton_grid.dart
│           └── search_screen.dart
│
├── gen/
│   ├── assets.gen.dart
│   └── fonts.gen.dart
│
├── bookia_app.dart
├── firebase_options.dart
└── main.dart
```

</details>

### 📦 Folder Naming Convention

| Folder | Purpose |
|---|---|
| `cubit/` | Cubit + State files |
| `data/models/` | API response models |
| `data/repo/` | Repository — all API/DB calls |
| `ui/widgets/` | Screen-specific decomposed widgets |
| `core/widgets/` | Reusable app-wide widgets |
| `core/theme/` | Colors, styles, theme extension, cubit |

---

## 🎨 Theming

Bookia uses a custom `ThemeExtension` called `AppColorScheme` registered on both `lightTheme` and `darkTheme`. This allows every widget to access semantic color tokens via:

```dart
context.appColors.background
context.appColors.surface
context.appColors.textPrimary
context.appColors.primaryColor  // always AppColors.primaryColor (gold)
```

Theme preference is persisted to Hive and restored before `runApp` — no flash on startup.

---

## 📡 API Layer

All API responses are wrapped in a `Freezed` sealed class:

```dart
@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(String error) = Failure<T>;
}
```

This forces every caller to handle both success and failure explicitly with no unchecked nulls.

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/Anas3Ezz/bookia.git

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## 👨‍💻 Author

**Anas Ezz** — Flutter Developer 🇪🇬

Built as a production-quality portfolio project showcasing clean architecture, scalable state management, and professional UI/UX.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/ezzans)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/Anas3Ezz)
[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://youtube.com/@Anas3Ezz)
