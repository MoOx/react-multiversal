open ReactNative;

let styles =
  Style.(
    StyleSheet.create({
      "item": viewStyle(~justifyContent=`center, ~alignItems=`center, ()),
      "text": textStyle(~flex=1., ~fontSize=10., ~marginTop=1.5->dp, ()),
    })
  );

[@react.component]
let make = (~text, ~icon, ~isActive, ~colorActive, ~colorInactive, ()) => {
  <View style=styles##item>
    {icon(
       ~width=24.,
       ~height=24.,
       ~fill=isActive ? colorActive : colorInactive,
       (),
     )}
    <Text
      style=Style.(
        array([|
          styles##text,
          isActive
            ? textStyle(~color=colorActive, ())
            : textStyle(~color=colorInactive, ()),
        |])
      )>
      text->React.string
    </Text>
  </View>;
};

let default = make;
