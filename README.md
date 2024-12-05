# Design Test

This project serves as a **development foundation** for the Softcar application. Its purpose is to test and validate all the necessary components for the proper functioning of the app, as well as the tools we will use. The project structure is subject to constant evolution to meet development needs.

---

## Instructions to Configure and Build the Project

### 1. Java Configuration
The project requires **Java 17** to work correctly. If you are using a version higher than Java 17, follow the recommendations provided here:  
[Flutter Issue #156304 - Comment](https://github.com/flutter/flutter/issues/156304#issuecomment-2397707812).

#### Check the Java Version in the Project
To verify the Java version used in your Flutter environment, run the following command:
```bash
flutter doctor --verbose
```

If the version displayed for **Java** is higher than 17 (e.g., OpenJDK Runtime Environment 18 or 19), it is recommended to switch to **Java 17** to avoid compatibility issues.

#### Configuring Java 17 for Windows
1. **Download JDK 17**:  
   Download the Java Development Kit (JDK) 17 from [AdoptOpenJDK](https://adoptium.net/) or [Oracle](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html).

2. **Set the `JAVA_HOME` Environment Variable**:
    - Open **Environment Variables** (type "Environment Variables" in the Start menu search bar).
    - Under "System Variables," click **New**, and add:
        - **Variable Name**: `JAVA_HOME`
        - **Variable Value**: Path to the JDK installation directory (e.g., `C:\Program Files\Java\jdk-17`).
    - Add the `bin` folder of the JDK to the `Path` variable:
        - Select the `Path` variable under "System Variables" and click **Edit**.
        - Add `C:\Program Files\Java\jdk-17\bin` as a new entry.

3. **Configure Flutter to Use Java 17**:  
   Run the following command in your terminal:
   ```bash
   flutter config --jdk-dir %JAVA_HOME%
   ```

4. **Verify Configuration**:
    - Restart your terminal or IDE.
    - Run:
      ```bash
      flutter doctor --verbose
      ```
      Ensure the Java version is correctly detected as Java 17.

---

#### Configuring Java 17 for Mac/Linux
1. **Install JDK 17 Using Homebrew** (Mac/Linux):  
   If you are on macOS or Linux, install JDK 17 using Homebrew:
   ```bash
   brew install openjdk@17
   ```

2. **Set the `JAVA_HOME` Environment Variable**:
    - For Mac, add this to your shell configuration file (e.g., `~/.zshrc` or `~/.bashrc`):
      ```bash
      export JAVA_HOME=/opt/homebrew/opt/openjdk@17
      export PATH="$JAVA_HOME/bin:$PATH"
      ```

    - For Linux, the location may vary depending on the package manager, but it's typically in `/usr/lib/jvm`. Check the exact location with:
      ```bash
      ls /usr/lib/jvm
      ```
      Update your shell configuration accordingly.

3. **Configure Flutter to Use Java 17**:
   Run the following command:
   ```bash
   flutter config --jdk-dir $JAVA_HOME
   ```

4. **Verify Configuration**:
    - Restart your terminal or IDE.
    - Run:
      ```bash
      flutter doctor --verbose
      ```
      Ensure the Java version is correctly detected as Java 17.

---

### 2. `.env` File
Create a `.env` file at the root of the project to define the required environment variables. Add the URL or path for the API used by the project. Example:
```env
API_KEY=https://your-api-url.com
```

---

## Additional Notes
- **Project Structure Evolution**: The current project structure is temporary and will be adjusted as new requirements arise.
- **Flutter Troubleshooting**: If you encounter configuration issues, run:
  ```bash
  flutter doctor --verbose
  ```
  This will provide detailed information to diagnose any dependency problems.

---

This document is designed to evolve alongside the project. Feel free to update it as new requirements emerge.