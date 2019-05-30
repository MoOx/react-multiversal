open Belt;

[@react.component]
let make = (~style=?, ~children=?) => {
  <div className="BlurView" ?style>
    {children->Option.getWithDefault(React.null)}
  </div>;
};
