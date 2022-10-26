open ReactNative

let styles = {
  open Style
  {
    "title": style(~fontSize=34., ~fontWeight=FontWeight._700, ~color=Predefined.Colors.dark, ()),
  }
}->StyleSheet.create

@react.component
let make = (~style as styl=?, ~children) =>
  <Text
    allowFontScaling=false
    style={
      open Style
      arrayOption([Some(styles["title"]), styl])
    }>
    children
  </Text>
