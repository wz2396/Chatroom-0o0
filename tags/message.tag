<message>
  <span class="name">{ msg.name } </span>
  <span class="gender">{ msg.gender }</span>
	<span class="content"> :   { msg.message }</span>
	<span class="time"></br>{ msg.time }</span>
  <div class="setting">
	<span>
	<i class="fa fa-thumbs-down" onclick={ thumbsDown }></i>{ msg.dislike }
</span>
<span >
	<i class="fa fa-thumbs-up" onclick={ thumbsUp }></i> { msg.like }
</span>
<span >
	<i class="far fa-trash-alt" onclick={ deleteMsg }></i>
</span>
</div>
	<script>
		var that = this;
	//	var times=0;
  //get id

		thumbsUp(e) {
      var id=this.msg.id;
			var newClick=this.msg.like++;
      console.log(newClick);
      messagesRef.child(id).child('like').set(newClick);
		}
		thumbsDown(e) {
      var id=this.msg.id;
      var newClick=this.msg.dislike++;
      console.log(newClick);
			messagesRef.child(id).child('dislike').set(newClick);
		};
//how to prevent double click
    deleteMsg(e) {
      var id=this.msg.id;
      messagesRef.child(id).set(null);
      this.update();
    }
	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid dodgerblue;
			padding: 0.5em;
		}
		:scope:not(:last-child) {
			margin-bottom: 1em;
		}
    .name {
      font-size:1.5rem;
      color:darkblue;
    }
    .gender {
      color:grey;
      font-size:0.8rem;
    }
    .content{
      font-size:1.7rem;
      padding:1.5rem;
    }
    .time {
      margin-top:1rem;
      font-size:0.7rem;
      color:grey;
    }
    .setting {
      margin-top:1rem;
    }
	</style>
</message>
