open Belt
open ReactNative

let styles = {
  open Style
  {
    "container": style(
      ~flexGrow=1.,
      ~flexShrink=0.,
      ~backgroundColor="#fff",
      ~overflow=#hidden,
      (),
    ),
  }
}->StyleSheet.create

let make = (~scrollYAnimatedValue=?, ~style as styl=?, ~children) =>
  <View
    style={
      open Style
      arrayOption([
        Some(styles["container"]),
        scrollYAnimatedValue->Option.map(_ => style(~borderRadius=10., ())),
        styl,
      ])
    }>
    {children}
  </View>
