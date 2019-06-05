open ReactNative;

let styles =
  Style.(
    StyleSheet.create({
      "wrapper":
        style(
          ~flexGrow=1.,
          ~flexShrink=1.,
          ~width=100.->pct,
          ~overflow=`hidden,
          ~alignItems=`center,
          (),
        ),
      "container":
        style(
          ~justifyContent=`center,
          ~flexGrow=1.,
          ~flexShrink=1.,
          ~width=100.->pct,
          ~paddingHorizontal=(Spacer.space /. 4.)->dp,
          (),
        ),
    })
  );

[@react.component]
let make =
    (
      ~wrapperStyle=?,
      ~style as styl=?,
      ~maxWidth as maxW=840.->Style.dp,
      ~children,
      (),
    ) => {
  <View style=Style.(arrayOption([|Some(styles##wrapper), wrapperStyle|]))>
    <View
      style=Style.(
        arrayOption([|
          Some(styles##container),
          Some(style(~maxWidth=maxW, ())),
          styl,
        |])
      )>
      children
    </View>
  </View>;
};
