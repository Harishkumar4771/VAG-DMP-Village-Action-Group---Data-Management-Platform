# vag_dmp_frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# VAG-DMP-Village-Action-Group---Data-Management-Platform
An offline-first Flutter web and mobile application designed to empower Village Action Leaders across India. This platform digitizes the documentation of local issues, meetings, and resolutions, facilitating seamless coordination with Gram Panchayats and Village Chairmen.
Village Action Leaders work alongside Gram Panchayats and Village Chairmen to solve ground-level problems. This application allows leaders to log issues, upload physical proof (photos, receipts, Gram Panchayat letters), and track progress—even without internet connectivity.

---

## 🚀 Key Features

* **Categorized Issue Reporting:** Issues are classified into four distinct problem domains:
  * 🛣️ **Road & Infrastructure** (`road`)
  * 🎓 **Education & Schools** (`education`)
  * 👥 **Society & Community Welfare** (`society`)
  * 💧 **Drinking Water Distribution** (`water`)
* **Verification & Proof Uploads:** Replaces informal WhatsApp sharing by letting leaders upload:
  * Before & After photos of resolved work
  * Official Gram Panchayat approval letters and notices
  * Expenditure bills and receipts
* **Offline-First Architecture:** Full CRUD operations using **Isar Database**. Users can create, update, and review records anywhere without network dependency.
* **Automatic Cloud Sync:** A background connectivity listener detects when internet access becomes available and automatically uploads pending local data and attachments.
* **Category Folder Filtering:** Easily view and manage issues filtered by category folders or overall status (`Reported`, `In Progress`, `Escalated`, `Resolved`).

---

## 🛠 Tech Stack

* **Framework:** Flutter (Web & Mobile)
* **Local Database:** Isar Database (Fast NoSQL local storage)
* **Architecture:** Feature-First / Domain-Driven Design
* **State & Sync Management:** Connectivity-aware background sync engine

---

## 📂 Project Structure

This project follows a clean **Feature-First Architecture** to keep the codebase modular and readable:

```text
lib/
├── main.dart
├── core/                       # App-wide shared components
│   ├── theme/                  # App styling, color palette, and typography
│   ├── network/                # Connectivity listeners & sync services
│   ├── database/               # Isar DB setup and configuration
│   └── widgets/                # Reusable UI widgets (cards, buttons, pickers)
│
├── features/                   # Independent modular features
│   ├── dashboard/              # Program performance stats across villages
│   ├── issues/                 # Issue tracking, categories, and proof uploads
│   ├── villages/               # 850+ Village directories and profiles
│   └── meetings/               # Gram Sabha & committee meeting schedules
