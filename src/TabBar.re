open Belt;
open ReactNative;

let tabbarHeight = 50.;

let styles =
  Style.(
    StyleSheet.create({
      "wrapper":
        style(
          ~borderTopWidth=Predefined.hairlineWidth,
          ~borderColor=Predefined.Colors.separator,
          (),
        ),
      "container":
        style(
          ~flex=1.,
          ~flexDirection=`row,
          ~minHeight=tabbarHeight->dp,
          ~alignItems=`center,
          (),
        ),
      "itemWrapper": style(~flex=1., ~justifyContent=`center, ()),
      "item": style(~justifyContent=`center, ~alignItems=`center, ()),
      "itemText": style(~flex=1., ~fontSize=10., ~marginTop=1.5->dp, ()),
    })
  );

type link = {
  link: string,
  text: string,
  icon: (~width: float, ~height: float, ~fill: string, unit) => React.element,
  isActive: (string, string) => bool,
};

module DefaultWrapper = {
  [@react.component]
  let make = (~style, ~children) => <View style> children </View>;
};

[@react.component]
let make =
    (
      ~links: array(link),
      ~colorInActive=Predefined.Colors.grey,
      ~colorActive=Predefined.Colors.blue,
      ~currentLocation,
      ~wrapperMake=DefaultWrapper.make,
      ~wrapperMakeProps=DefaultWrapper.makeProps,
    ) => {
  <SafeAreaView
    key={Predefined.hairlineWidth->Js.Float.toString}
    // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
    style=styles##wrapper>
    <View style=styles##container>
      {links
       ->Array.map(item =>
           React.createElementVariadic(
             wrapperMake,
             wrapperMakeProps(
               ~key={item.link},
               ~style=styles##itemWrapper,
               ~children=React.null,
               (),
             ),
             [|
               <View style=styles##item>
                 {item.icon(
                    ~width=24.,
                    ~height=24.,
                    ~fill=
                      item.isActive(currentLocation##pathname, item.link)
                        ? colorActive : colorInActive,
                    (),
                  )}
                 <Text
                   style=Style.(
                     arrayOption([|
                       Some(styles##itemText),
                       Some(style(~color=colorInActive, ())),
                       item.isActive(currentLocation##pathname, item.link)
                         ? Some(style(~color=colorActive, ())) : None,
                     |])
                   )>
                   item.text->React.string
                 </Text>
               </View>,
             |],
           )
         )
       ->React.array}
    </View>
  </SafeAreaView>;
};

let default = make;

// static placeholder
// can be used so you can properly scroll to bottom of the page
// or you can sticky something at the bottom depending on the tabbar visibility
module Placeholder = {
  [@react.component]
  let make = () => {
    <View style=styles##container />;
  };
};
