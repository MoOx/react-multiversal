open ReactNative

@react.component
let make = (~style as styl=?, ~children) =>
  <View
    style={
      open Style
      arrayOption([Some(Predefined.styles["col"]), styl])
    }>
    children
  </View>

module Center = {
  @react.component
  let make = (~style as styl=?, ~children) =>
    <View
      style={
        open Style
        arrayOption([Some(Predefined.styles["colCenter"]), styl])
      }>
      children
    </View>
}

module SpaceBetween = {
  @react.component
  let make = (~style as styl=?, ~children) =>
    <View
      style={
        open Style
        arrayOption([Some(Predefined.styles["colSpaceBetween"]), styl])
      }>
      children
    </View>
}
