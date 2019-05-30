open ReactNative;

let styles =
  Style.(
    StyleSheet.create({
      "separator":
        style(
          ~height=Predefined.hairlineWidth->pt,
          ~backgroundColor=Predefined.Colors.separator,
          (),
        ),
    })
  );

[@react.component]
let make = (~style as s=?) => {
  <View
    key={Predefined.hairlineWidth->Js.Float.toString}
    // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
    style=Style.(arrayOption([|Some(styles##separator), s|]))
  />;
};
