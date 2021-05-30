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
                main.addClickListenerToButtons();
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
                        //location.replace("http://localhost/webprog2/subpage.html");
                    }
                };

                this.xhttp.open("POST", "Service/JoinChannel.php", true);
                this.xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

                //Itt még ki kell deríteni, hogy ki szeretne csatlakozni
                this.xhttp.send(
                    "u=" + this.username +
                    "&p=" + this.password +
                    "&ch=" + id +
                    "&player=1");
            }
        },

        onClickNew: function(event)
        {
            event.preventDefault();

            //Új csatorna létrehozása és aloldalváltás
            location.replace("http://localhost/webprog2/subpage.html");
        },

        onClickSignOut: function(event)
        {
            event.preventDefault();

            //Kijelentkezés és aloldalváltás
            location.replace("http://localhost/webprog2/subpage.html");
        },

        addClickListenerToButtons: function()
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
            this.xhttp = new XMLHttpRequest();

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

            //Requesting channel list from server side
            this.xhttp.onreadystatechange = this.LoadChannels;

            this.xhttp.open("POST", "Service/LoadChannels.php", true);
            this.xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            this.xhttp.send( "u=" + this.username + "&p=" + this.password );
        }
    };

    return main;
})();