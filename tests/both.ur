fun main () : transaction page = return <xml>
 <body>
   <form>
     <textbox{#Text}/><submit action={onsubmit}/>
   </form>
 </body>
</xml>

and onsubmit r = return <xml/>
