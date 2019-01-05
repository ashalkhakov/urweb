val fpage = fn [p :: (Type * Type)] => fn (f : p.1 -> string) => fn (x : p.1) => (return <xml><body>
        {cdata (f x)}
</body></xml>) : transaction page

val page_string =
    fpage [(string, int)] (fn x => x)

val main : unit -> transaction page = fn () => return <xml><body>
        <a link={page_string "Hi"}>Hi</a>
</body></xml>
