open ReactNative

@react.component
let make = (~style as styl=?, ~children) =>
  <View
    style={
      open Style
      arrayOption([Some(Predefined.styles["center"]), styl])
    }>
    {children}
  </View>
