open ReactNative;

let styles =
  Style.{
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
  }
  ->StyleSheet.create;

[@react.component]
let make = (~children, ()) => {
  <SafeAreaView style=styles##wrapper>
    <View style=styles##container> children </View>
  </SafeAreaView>;
};

// static placeholder
// can be used so you can properly scroll to bottom of the page
// or you can sticky something at the bottom depending on the tabbar visibility
module Placeholder = {
  [@react.component]
  let make = () => {
    <View style=styles##container />;
  };
};
