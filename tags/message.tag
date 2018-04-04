<message>
  <span>{ msg.name }</span>
	<span>{ msg.message }</span>
	<span>{ msg.gender }</span>
	<span>{ msg.time }</span>
	<span>
	<i class="fa fa-thumbs-down" onclick={ thumbsDown }></i>{ msg.dislike }
</span>
<span>
	<i class="fa fa-thumbs-up" onclick={ thumbsUp }></i> { msg.like }
</span>
<span>
	<i class="far fa-trash-alt" onclick={ deleteMsg }></i>
</span>

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
	</style>
</message>
