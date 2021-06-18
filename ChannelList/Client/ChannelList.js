const ChannelList = (function()
{
    main = 
    {
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
                        //location.replace("http://localhost/webprog2/GameBoard/index.html");
                    }
                };

                
                this.xhttp.open("POST", "Service/JoinChannel.php", false);
                
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

            location.replace("http://localhost/webprog2/GameBoard/index.html");
        },

        onClickSignOut: function(event)
        {
            event.preventDefault();

            location.replace("http://localhost/webprog2/login/login.html");
        },

        onClickRecords: function(event)
        {
            event.preventDefault();

            location.replace("http://localhost/webprog2/table/table.html");
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
            {
                //Convert JSON to JavaScript object
                const result = JSON.parse(this.responseText); //A responseText-BEN KI KELL CSERÉLNI MINDEN 'null' SZÖVEGET '' -RA!
                const channels = document.getElementById("channels");

                //Fill the channel list
                for (let index = 0; index < result.length; index++)
                {
                    let htmlRow = "";
                    const row = result[index];
                    htmlRow += `
                <ul>
                    <li>` + row["name"] + `</li>
                    <li>` + row["player_1_ID"] + `</li>
                    <li>` + row["player_2_ID"] + `</li>
                    <button value="` + row["Id"] + `"`;
                    htmlRow += (row["status"] === 'u') ? ` class="enabled"` : ``;
                    htmlRow += `>Csatlakozás</button>
                </ul>`;
                    
                    channels.innerHTML += htmlRow.replaceAll('null', '');
                }
                
                main.addClickListenerToButtonsOfChannels();
            }
        },

        Init: function()
        {
            //These has to be replaced to the usrname and passwd of the current user
            this.username = "outsider";
            this.password = "outsider";
            this.xhttp = new XMLHttpRequest(); //Ez lesz magának a kérésnek az objektuma. A szerver oldal ezen keresztül küld választ.

            //Add click event listener to button NEW CHANNEL
            let button = document.getElementById("new_channel");
            button.addEventListener("click", function(event)
            {
                main.onClickNew(event);
            });

            //Add click event listener to button SIGN OUT
            button = document.getElementById("sign_out");
            button.addEventListener("click", function(event)
            {
                main.onClickSignOut(event);
            });

            //Add click event listener to button RECORDS
            button = document.getElementById("records");
            button.addEventListener("click", function(event)
            {
                main.onClickRecords(event);
            });

            //Requesting channel list from server side
            this.xhttp.onreadystatechange = this.LoadChannels;

            this.xhttp.open("POST", "Service/LoadChannels.php", false);
            this.xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            this.xhttp.send( "u=" + this.username + "&p=" + this.password );
        }
    };

    return main;
})();