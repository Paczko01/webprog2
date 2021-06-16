const ChannelList = (function()
{
    main = 
    {
        Html:
        {
            Content: "",
            ContentReady: false,

            OnHtmlContentIsReady: function(val){
                document.getElementById("channels").innerHTML = main.Html.Content.replaceAll('null', '');
                main.addClickListenerToButtonsOfChannels();
            },

            set Ready(val){
                if (typeof val === typeof true){
                    this.ContentReady = val;
                    if(val == true){
                        this.OnHtmlContentIsReady(val);
                    }
                }
            },

            get Ready(){
                return this.ContentReady;
            },
        },

        onClickJoin: function(event)
        {
            event.preventDefault();
            const id = event.target.getAttribute("value");

            if (event.target.classList.contains("enabled"))
            {
                this.xhttp.onreadystatechange = function ()
                {
                    if (this.readyState == 4 && this.status == 200)
                    {
                        console.log(this.responseText);
                        //Itt még le kell ellenőrizni, hogy sikerült-e az adatbázisban a csatlakozás mielőtt oldaltváltunk
                        location.replace("http://localhost/webprog2/GameBoard/index.html");
                    }
                };
                /*  Eseménykezelő definiálása: Ha a szerveroldal megváltoztatja a "readyState" mezőt,
                    akkor ez a névtelen függvény fut le akárcsak a w3schools példáiban*/

                
                this.xhttp.open("POST", "Service/JoinChannel.php", true);
                /*  1. paraméter: POST metódussal megy a kérés (A kérés paraméterei nem az URL-ben lesznek, hanem a "send" függvényben.)
                    2. paraméter: A Service mappában a JoinChannel.php -nak megy a kérés
                    3. paraméter: Asszinkron történjen-e a kommunikáció a szerver és a kliens között.
                       (Asszinkron: háttérben megy a kérés, és fut tovább a kliensoldali webprogram.
                        Szinkron: A kliens megvárja a szerver válaszát. Addig nem fut a kliensoldali webprogram.)*/
                
                
                this.xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                //Itt még ki kell deríteni, hogy ki szeretne csatlakozni
                this.xhttp.send(
                    "u=" + this.username +
                    "&p=" + this.password +
                    "&ch=" + id +
                    "&player=1");
                /*  Itt kell megadni a szerveroldali webprogramnak fontos prarmétereket.
                    Specifikusan egy csatornához való csatlakozáskor kell az, hogy ki (Id, név, jelszó) hova (csatornaID) akar csatlakozni.*/
            }
        },

        onClickNew: function(event)
        {
            event.preventDefault();

            //Új csatorna létrehozása és aloldalváltás
            location.replace("http://localhost/webprog2/GameBoard/index.html");
        },

        onClickSignOut: function(event)
        {
            event.preventDefault();

            //Kijelentkezés és aloldalváltás
            location.replace("http://localhost/webprog2/login/login.html");
        },

        onClickRecords: function(event)
        {
            event.preventDefault();

            //Kijelentkezés és aloldalváltás
            //location.replace("http://localhost/webprog2/?/?.html");
        },

        addClickListenerToButtonsOfChannels: function()
        {

            const channels = document.querySelectorAll("#channels ul");
            for (let i = 0; i < channels.length; i++) {
                const channel = channels[i];
                channel.addEventListener("click", function(event)
                {
                    main.onClickJoin(event);
                });
            }
        },

        LoadChannels: function()
        {
            if (this.readyState == 4 && this.status == 200)
            /*  Ha a readyState 4-es értéket kap, az azt jelenti, hogy mindennel elkészült a szerver oldal, amit a kliens oldal kért.
                Ha a status 200-as értéket kap, az azt jelenti, hogy minden hibamentesen zajlott.
                Bővebb információk: https://www.w3schools.com/xml/ajax_xmlhttprequest_response.asp
                */
            {
                //Convert JSON to JavaScript object
                const result = JSON.parse(this.responseText); //A responseText-BEN KI KELL CSERÉLNI MINDEN 'null' SZÖVEGET '' -RA!
                const channels = document.getElementById("channels");

                //Clear the temp channel list
                main.Html.Ready = false;
                main.Html.Content = "";

                //Fill the temp channel list
                for (let index = 0; index < result.length; index++)
                {
                    const row = result[index];
                    const dsbld = " disabled";
                    main.Html.Content += `
                <ul>
                    <li>` + row["name"] + `</li>
                    <li>` + row["player_1_ID"] + `</li>
                    <li>` + row["player_2_ID"] + `</li>
                    <button value="` + row["Id"] + `"`;
                    main.Html.Content += (row["status"] === 'u') ? ` class="enabled"` : ``;
                    main.Html.Content += `>Csatlakozás</button>
                </ul>`;
                }
                main.Html.Ready = true;
            }
        },

        /*LoadChannels: function()
        {
            main.ConvertResponseToHtml(this);
        },*/

        Init: function()
        {
            //These has to be replaced to the usrname and passwd of the current user
            this.username = "outsider";
            this.password = "outsider";
            this.xhttp = new XMLHttpRequest(); //Ez lesz magának a kérésnek az objektuma. A szerver oldal ezen keresztül küld választ.

            //Add click event listener to button NEW CHANNEL
            let button = document.querySelector("#head button");
            button.addEventListener("click", function(event)
            {
                main.onClickNew(event);
            });

            //Add click event listener to button SIGN OUT
            button = document.querySelector("footer button");
            button.addEventListener("click", function(event)
            {
                main.onClickSignOut(event);
            });

            //Add click event listener to button SIGN OUT
            button = document.querySelector("footer button");
            button.addEventListener("click", function(event)
            {

                main.onClickRecords(event);
            });

            //Requesting channel list from server side
            this.xhttp.onreadystatechange = this.LoadChannels;
            /*  Eseménykezelő definiálása: Ha a szerveroldal megváltoztatja a "readyState" mezőt,
                akkor a LoadChannels függvény fut le. Ezt a w3schools névtelen függvényekkel oldja meg:
                this.xhttp.onreadystatechange = function()
                {
                    if (this.readyState == 4 && this.status == 200)
                    {
                        ....
                    }
                }
                */

            this.xhttp.open("POST", "Service/LoadChannels.php", true);
            /*  1. paraméter: POST metódussal megy a kérés (A kérés paraméterei nem az URL-ben lesznek, hanem a "send" függvényben.)
                2. paraméter: A Service mappában a LoadChannels.php -nak megy a kérés
                3. paraméter: Asszinkron történjen-e a kommunikáció a szerver és a kliens között.
                   (Asszinkron: háttérben megy a kérés, és fut tovább a kliensoldali webprogram.
                    Szinkron: A kliens megvárja a szerver válaszát. Addig nem fut a kliensoldali webprogram.)*/

            this.xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            this.xhttp.send( "u=" + this.username + "&p=" + this.password );
            /*  Itt kell megadni a szerveroldali webprogramnak fontos prarmétereket.
                Specifikusan a csatornák betöltéséhez nem kell más, mint hogy ki akarja látni a csatornák listáját.*/
        }
    };

    return main;
})();