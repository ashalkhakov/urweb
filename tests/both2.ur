fun main () : transaction page =
    let
        fun onsubmit r = return <xml>{[r.Text]}</xml>
    in
        return <xml>
          <body>
            <form>
              <textbox{#Text}/><submit action={onsubmit}/>
            </form>
          </body>
        </xml>
    end


