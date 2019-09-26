open ReactNative;

let styles =
  Style.(
    StyleSheet.create({
      "wrapper":
        viewStyle(
          ~borderTopWidth=StyleSheet.hairlineWidth,
          ~borderColor="#E3E4E5",
          (),
        ),
      "container":
        viewStyle(
          ~flex=1.,
          ~flexDirection=`row,
          ~minHeight=50.->dp,
          ~alignItems=`center,
          (),
        ),
    })
  );

[@react.component]
let make = (~children, ()) => {
  <SafeAreaView style=styles##wrapper>
    <View style=styles##container> children </View>
  </SafeAreaView>;
};

let default = make;
