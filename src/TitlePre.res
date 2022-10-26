open ReactNative

let styles = {
  open Style
  {
    "title": style(~fontSize=14., ~fontWeight=FontWeight._600, ~color=Predefined.Colors.grey, ()),
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
