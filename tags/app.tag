<app>

	<h1>Welcome to Date Chat!</h1>

	<div class="chatLog" ref="chatLog">
		<!-- Messages go here: -->
		<message each={ msg in chatLog }></message>
	</div>
	<div class=" sendMsg row">

		<div class="gender">
			<label>
				Male
				<input type="radio" name="genderInput" value="male">
			</label>
			<label>
				Female
				<input type="radio" name="genderInput" value="female">
	</div>
	<div class="col-2">
<input type="text" ref="nameInput" onkeypress={ sendMsg } placeholder="Enter Name">
</div>
	<div class="col-4">
	<input type="text" ref="messageInput" onkeypress={ sendMsg } placeholder="Enter Message">
	</div>
	<div class="col-2">
	<button type="button" onclick={ sendMsg }>SEND</button>
</div>
</div>
	<script>
		var that = this;

		// Global Cached references
		// See index.html for var database, messagesRef

		// Demonstration Data
		this.chatLog = []; // Empty Data

		messagesRef.on('value', function(snapshot){
		  var messagesData = snapshot.val(); // .val() returns to us the raw data object from snapshot
      // var messagesId = snapshot.key();


			// Loop through each obj in messagesData and push each message object into our that.chatLog array
			for (key in messagesData) {
				that.chatLog.push(messagesData[key]);
			}

			that.update(); // Manually kick-off the tag update after we get any fresh changed data.
		});

	  /*messagesRef.on('remove_child', function(snapshot) {
			var messagesData = snapshot.val();
		//var messagesId=snapshot.key();
			var deleteData;
			if (var i=0; i< that.chatLog.length; i++) {
				if (that.chatLog[i].id === messagesId){
						target=that.chatLog[i];
						break
				}
			}
			var index = that.chatLog.indexOf(deleteData);
			that.chatLog.splice(index,1);
			that.update();

		})
*/

		sendMsg(e) {
			if (e.type == "keypress" && e.key !== "Enter") {
				e.preventUpdate = true; // Prevents riot from auto update.
				return false; // Short-circuits function (function exits here, does not continue.)
			}
			//get id
			var messagesId=messagesRef.push().key;
			//console.log(messagesId);
			// get date in
			var d=new Date().toUTCString();
      //sorry it's not in Riot way
			var genderVal=document.querySelector('input[name="genderInput"]:checked').value;
			var msg = {
				id:messagesId,
				message: this.refs.messageInput.value,
				name: this.refs.nameInput.value,
				gender:genderVal,
				time:d,
				like:0,
				dislike:0
			};

			/***
				We no longer need to push data directly into our array on the client-side when we create a message object.
				The source of the state of this tag (chatLog) is with Firebase.
				Our firebase listener links our chatLog list directly to the database. That becomes the source
				of the state of this tag. The chatLog list is merely a reactionary reflection of that truth data.

				this.chatLog.push(msg); // Prior code that pushed msg data directly to the chatLog array
			***/

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
			this.refs.nameInput.value="";
			this.refs.messageInput.focus();
			this.refs.nameInput.value="";
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
