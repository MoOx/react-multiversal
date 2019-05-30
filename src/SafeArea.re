let statusBarHeight = 20.;

module Top = {
  [@react.component]
  let make = () => {
    <div
      style={ReactDOMRe.Style.make(
        ~width="100%",
        ~height="env(safe-area-inset-top)",
        (),
      )}
    />;
  };
};
module Bottom = {
  [@react.component]
  let make = () => {
    <div
      style={ReactDOMRe.Style.make(
        ~width="100%",
        ~height="env(safe-area-inset-bottom)",
        (),
      )}
    />;
  };
};

module Left = {
  [@react.component]
  let make = () => {
    <div
      style={ReactDOMRe.Style.make(
        ~height="100%",
        ~width="env(safe-area-inset-left)",
        (),
      )}
    />;
  };
};
module Right = {
  [@react.component]
  let make = () => {
    <div
      style={ReactDOMRe.Style.make(
        ~height="100%",
        ~width="env(safe-area-inset-right)",
        (),
      )}
    />;
  };
};
