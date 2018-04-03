<message>
  <span>{ msg.name }</span>
	<span>{ msg.message }</span>
	<span>{ msg.gender }</span>
	<span>{ msg.time }</span>
	<span>
	<i class="fa fa-thumbs-o-down" onclick={ thumbsDown }></i>{ msg.dislike }
</span>
<span>
	<i class="fa fa-thumbs-o-up" onclick={ thumbsUp }></i> { msg.like }
</span>
<span>
	<i class="far fa-trash-alt" onclick={ deleteMsg }></i>
</span>

	<script>
		var that = this;
		var times=0;
		thumbsUp(e) {
			
		}
		thumbsDown(e) {
			times++;
			msg.like=times;
			messagesRef.push(msg);
		};

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
