module SafeAreaProvider = {
  [@react.component] [@bs.module "react-native-safe-area-context"]
  external make: (~children: React.element=?) => React.element =
    "SafeAreaProvider";
};

type insets = {
  .
  "top": float,
  "bottom": float,
  "left": float,
  "right": float,
};

[@bs.module "react-native-safe-area-context"]
external useSafeArea: unit => insets = "useSafeArea";

module SafeAreaConsumer = {
  [@react.component] [@bs.module "react-native-safe-area-context"]
  external make: (~children: insets => React.element=?) => React.element =
    "SafeAreaConsumer";
};

module SafeAreaView = {
  [@react.component] [@bs.module "react-native-safe-area-context"]
  external make: (~children: React.element=?) => React.element =
    "SafeAreaView";
};
