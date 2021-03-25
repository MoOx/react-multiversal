open ReactNative

let styles = {
  open Style
  {
    "title": style(~fontSize=34., ~fontWeight=#_700, ~color=Predefined.Colors.dark, ()),
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
