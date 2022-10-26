open ReactNative

@react.component
let make = (~style as styl=?, ~children) =>
  <View
    style={
      open Style
      arrayOption([Some(Predefined.styles["row"]), styl])
    }>
    children
  </View>

module Center = {
  @react.component
  let make = (~style as styl=?, ~children) =>
    <View
      style={
        open Style
        arrayOption([Some(Predefined.styles["rowCenter"]), styl])
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
        arrayOption([Some(Predefined.styles["rowSpaceBetween"]), styl])
      }>
      children
    </View>
}

module Wrap = {
  @react.component
  let make = (~style as styl=?, ~children) =>
    <View
      style={
        open Style
        arrayOption([Some(Predefined.styles["rowWrap"]), styl])
      }>
      children
    </View>

  module Center = {
    @react.component
    let make = (~style as styl=?, ~children) =>
      <View
        style={
          open Style
          arrayOption([Some(Predefined.styles["rowWrapCenter"]), styl])
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
          arrayOption([Some(Predefined.styles["rowWrapSpaceBetween"]), styl])
        }>
        children
      </View>
  }
}
