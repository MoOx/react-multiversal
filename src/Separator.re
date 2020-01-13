open ReactNative;

let styles =
  Style.{
    "separator":
      style(
        ~height=Predefined.hairlineWidth->dp,
        ~backgroundColor=Predefined.Colors.separator,
        (),
      ),
  }
  ->StyleSheet.create;

[@react.component]
let make = (~style as s=?) => {
  <View
    key={Predefined.hairlineWidth->Js.Float.toString}
    // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
    style=Style.(arrayOption([|Some(styles##separator), s|]))
  />;
};
