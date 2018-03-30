<app>
  <h1>Welcome to this little dateroom</h2>

	<div class="chatLog" ref="chatLog">
		<!-- Messages go here: -->
		<message each={ msg in chatLog }></message>
	</div>
  <input type="text" ref="nameInput" onkeypress={ sendMsg } placeholder="Enter Name">
	<div>
		<label>
			female
			<input type="radio" name="gender" value="female" onclick={ updateGender }>
		</label>
		<label>
			male
			<input type="radio" name="gender" value="male" onclick={ updateGender }>
		</label>
	</div>
	<input type="text" ref="messageInput" onkeypress={ sendMsg } placeholder="Enter Message">

	<button type="button" onclick={ sendMsg }>SEND</button>

	<script>
		var that = this;

		// Global Cached references
		// See index.html for var database, messagesRef

		// Demonstration Data
		this.chatLog = []; // Empty Data
    /*the data should be like
    [{
    name:"Wanqiu Zhu",
    message:"Hello, world",
    gender:"female",
    time:"12:20",
    color:"800000"
  },
  name:"HAHAHHA",
  message:"byebye",
  gender:"male",
  time:"12:40",
  color:"FF0000"
    }]
    */
		/*messagesRef.on('value', function(snapshot){
		  var messagesData = snapshot.val(); // .val() returns to us the raw data object from snapshot

			that.chatLog = []; // if we had prior data, clear it so we don't get repeats. You can try removing this line to see what happens.

			// Loop through each obj in messagesData and push each message object into our that.chatLog array
			for (key in messagesData) {
				that.chatLog.push(messagesData[key]);
			}

			that.update(); // Manually kick-off the tag update after we get any fresh changed data.
		});
*/
  messagesRef.on('add_child', function(e){
    var mesData=e.val();
    var id=e.key;
    mesData.id=id;
    that.chatLog.push(mesData);
    that.update();
  })

  messagesRef.on('remove_child', function(e) {
    var mesData=e.val();
    var id=e.key;
    var targetMes;
    for (let i = 0; i < that.chatLog.length; i++) {
    				if (that.chatLog[i].id === id) {
    					targetMes = that.chatLog[i];
    					break;
    				}
          }
    var index=that.chatLog.indexOf(targetMes);
    var that.chatLog.splice(index,1);
    that.update();

  })

		sendMsg(e) {
			if (e.type == "keypress" && e.key !== "Enter") {
				e.preventUpdate = true; // Prevents riot from auto update.
				return false; // Short-circuits function (function exits here, does not continue.)
			}

			var msg = {
				message: this.refs.messageInput.value;
        name:this.refs.nameInput;
        gender:this.refs.genderInput;

			};

			/***
				We no longer need to push data directly into our array on the client-side when we create a message object.
				The source of the state of this tag (chatLog) is with Firebase.
				Our firebase listener links our chatLog list directly to the database. That becomes the source
				of the state of this tag. The chatLog list is merely a reactionary reflection of that truth data.

				this.chatLog.push(msg); // Prior code that pushed msg data directly to the chatLog array
			***/
      if (this.refs.messageInput.value !=='') {
        msg.userName=this.user
      }
			messagesRef.push(msg);
			// Notice the difference between messagesRef.push() vs. this.chatLog.push();
			// Here, we are using the Firebase push() to push to the database reference.
			// With that.chatLog.push() we are using the JS Array push() to push directly to the array.

			/***
				Also notice that we do not that.update() here. All we do is change the state of data on our database.
				Our listener to the database above, is what will react to the changes on our database, then sync our chatLog
				to the data in our database, then kick-off manually that.update() of this riot tag.
			***/

			this.clearInput();
		}

		clearInput(e) {
			this.refs.messageInput.value = "";
			this.refs.messageInput.focus();
		}
	</script>

	<style>
		:scope {
			display: block;
			font-family: Helvetica;
			font-size: 1em;
		}
		.chatLog {
			border: 1px solid grey;
			padding: 1em;
			margin-bottom: 1em;
		}
		[ref="messageInput"], button {
			font-size: 1em;
			padding: 0.5em;
		}
		[ref="messageInput"] {
			width: 50%;
		}
	</style>
</app>
