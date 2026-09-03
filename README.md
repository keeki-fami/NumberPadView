# CalculatorView
This is a swift package that provides a NumberPad UI and logic.
<!--![numericpad](./photo/smartphone_picture.png)-->
<img src="./photo/smartphone_picture.png" width="30%">

# platform
- iOS18+
# Usage
If you use SPM (Swift Package Manager), then add this repository to your project, and import `NumberPad`
```Swift
import NumberPad
```
pass binding of String property wrapped by `@State`.
```Swift
@State var text: String = ""
var body: some View {
    NumberPadView($text)
}
```
