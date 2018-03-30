<message>

	<span>{ msg.message }</span>
	<span>{ msg.name }<span>
	<span>{ msg.gender }<span>
	<span>{ msg.time }<span>
	<

	<script>
		var that = this;
		console.log('message.tag','name.tag','gender.tag','time.tag');
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
