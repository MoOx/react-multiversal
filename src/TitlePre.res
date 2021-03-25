open ReactNative

let styles = {
  open Style
  {
    "title": style(~fontSize=14., ~fontWeight=#_600, ~color=Predefined.Colors.grey, ()),
  }
}->StyleSheet.create

@react.component
let make = (~style as s=?, ~children) =>
  <Text
    allowFontScaling=false
    style={
      open Style
      arrayOption([Some(styles["title"]), s])
    }>
    children
  </Text>
