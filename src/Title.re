open ReactNative;

let styles =
  Style.(
    StyleSheet.create({
      "title":
        style(
          ~fontSize=34.,
          ~fontWeight=`_700,
          ~color=Predefined.Colors.dark,
          (),
        ),
    })
  );

[@react.component]
let make = (~style as s=?, ~children) => {
  <Text style=Style.(arrayOption([|Some(styles##title), s|]))>
    children
  </Text>;
};
