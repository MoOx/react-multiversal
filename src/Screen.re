open Belt;
open ReactNative;

let styles =
  Style.{
    "container":
      style(
        ~flexGrow=1.,
        ~flexShrink=0.,
        ~backgroundColor="#fff",
        ~overflow=`hidden,
        (),
      ),
  }
  ->StyleSheet.create;

let make = (~scrollYAnimatedValue=?, ~style as s=?, children) => {
  <View
    style=Style.(
      arrayOption([|
        Some(styles##container),
        scrollYAnimatedValue->Option.map(_ => style(~borderRadius=10., ())),
        s,
      |])
    )>
    ...children
  </View>;
};
