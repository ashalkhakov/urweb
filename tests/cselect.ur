fun main () =
    s <- source "";
    return <xml><body>
      <cselect source={s} onchange={v <- get s; alert ("Now it's " ^ v)}>
        <coption>Wilbur</coption>
        <coption>Walbur</coption>
      </cselect>

      <p>
        Hello, I'm <dyn signal={s <- signal s; return (cdata s)}/>.
        I'll be your waiter for this evening.
      </p>
    </body></xml>
