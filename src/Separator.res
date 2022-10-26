open ReactNative

let styles = {
  open Style
  {
    "separator": style(
      ~height=Predefined.hairlineWidth->dp,
      ~backgroundColor=Predefined.Colors.separator,
      (),
    ),
  }
}->StyleSheet.create

@react.component
let make = (~style as styl=?) =>
  <View
  // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
    key={Predefined.hairlineWidth->Js.Float.toString}
    style={
      open Style
      arrayOption([Some(styles["separator"]), styl])
    }
  />
