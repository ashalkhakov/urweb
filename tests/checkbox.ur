val handler = fn x => return <xml><body>
        {if x.A then cdata "Yes" else cdata "No"}
</body></xml>

val main = fn () => return <xml><body>
        <form>
                <checkbox{#A}/> How about it?<br/>
                <submit action={handler}/>
        </form>
</body></xml>
