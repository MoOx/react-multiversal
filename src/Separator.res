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
let make = (~style as s=?) =>
  <View
    key={Predefined.hairlineWidth->Js.Float.toString}
    style=// key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
    {
      open Style
      arrayOption([Some(styles["separator"]), s])
    }
  />
