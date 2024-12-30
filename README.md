# **Fampay-assignment**

**Description:**  
An Android app that dynamically renders contextual cards fetched from an API. The cards display text, images, buttons (CTAs), and support deeplink actions.

---

## 🚀 Features  

- **Dynamic Cards**: Renders cards based on API. 
- **Design Types**: Supports HC1, HC3, HC5, HC6, HC9 cards. 
- **Interactions**:
    - Long press HC3 cards to Dismiss Now or Remind Later.
    - Handles deeplinks on buttons and text.
- **Swipe to Refresh**: Reload cards.
- **State Management**: Handles loading, error states, and local storage.


---

### APK File Path
```bash
fampay_assigment/assets/apk/app-release.apk
```



## 🔑 Dependencies Used  

The project uses the following dependencies:  

| **Package**            | **Purpose**                       |
|-------------------------|-----------------------------------|
| `http`                 | For making HTTP API calls                       |
| `shared_preferences`             | For storing key-value pairs locally              |
| `url_launcher`         | For launching URLs and external apps                    |



---

## 📸 Screenshots
<p> <img src="https://github.com/user-attachments/assets/d844285c-d38d-4d9c-9790-35dee84ff4e9" width="300" hspace="10"/> <img src="https://github.com/user-attachments/assets/c2830cc1-752d-41da-bf56-e26dc33cabce" width="300" hspace="10"/><img src= "https://github.com/user-attachments/assets/b11ff56d-787f-477f-bddf-82d9faf0fb84" width="300"/> </p>

##  Project Setup  

Follow these steps to run the project locally:

### 1 **Prerequisites**  

Ensure you have the following installed:  
- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)  
- **IDE**: Android Studio or Visual Studio Code  
- **Device/Emulator**: Android/iOS device or simulator  

Check Flutter installation by running:  
```bash
flutter doctor
```

---

### 2️ **Clone the Repository**  
Clone the project to your local system:  
```bash
git clone https://github.com/mohitrajsinha/Fampay_Assigment.git
```
```bash
cd fampay_assignment
```

---

### 3️ **Install Dependencies**  
Install the required Flutter dependencies:  
```bash
flutter pub get
```

---

### 4️ **Run the Application**  

To run on an **Android** device:  
```bash
flutter run
```
