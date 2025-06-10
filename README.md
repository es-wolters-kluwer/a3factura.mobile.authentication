# Flutter WebView Example - Login with Token Interception

This project is a simple example of how to use a **WebView in Flutter** to:

✅ Perform login on a web page  
✅ Intercept the redirect URL (e.g.: `localhost`)  
✅ Extract parameters from the URL (`code`)  
✅ Perform a `GET` request to obtain a token from an API  
✅ Display the result in a **Dialog**  

---

## Technologies used

- [Flutter](https://flutter.dev/) (>= 3.10 recommended)
- [webview_flutter](https://pub.dev/packages/webview_flutter)
- [http](https://pub.dev/packages/http)

---

## Workflow

1. The WebView loads the login URL.
2. When the user successfully logs in, the WebView is redirected to a URL like `http://localhost?code=XXXXX`.
3. The app intercepts this URL, extracts the `code`, and performs a GET request to:
https://login-integracionesdev.a3software.com/api/tokens/registerToken?name=A3facturaMobile&code=XXXXX

4. The response body is displayed in a `Dialog` on the screen.

---

## Code structure

- `WebViewExample`: Main widget that loads the WebView.
- `NavigationDelegate`: Intercepts URLs navigated within the WebView.
- `getToken()`: Performs the GET request and calls `openDialog2()`.
- `openDialogWithResult()`: Displays a Dialog with the URL and response body.

---

## How to run

1. Clone this repository:
2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```

---

## Notes

⚠️ The redirect URL (`localhost`) is used for interception and get code
---

## License

This project is free to use for personal study and learning.  
(c)- paulorocha@wolterskluwer.com
