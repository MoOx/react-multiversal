open ReactNative;

let styles =
  Style.{
    "title":
      style(
        ~fontSize=14.,
        ~fontWeight=`_600,
        ~color=Predefined.Colors.grey,
        (),
      ),
  }
  ->StyleSheet.create;

[@react.component]
let make = (~style as s=?, ~children) => {
  <Text style=Style.(arrayOption([|Some(styles##title), s|]))>
    children
  </Text>;
};
