function pressButton(value) {
}
$('button').on('click', function(e){
    e.preventDefault();
    $("#pressedButton").val($(this).attr("name"));
    $("#remoteForm").ajaxSubmit({
        target: "#result",
        url: '/',
        beforeSubmit: function() {
            return true;
        },
        success: function(data) {
            $("#result").html(JSON.stringify(data));
        } 
    });
    $("#channelsForm").ajaxSubmit({
        target: "#result",
        url: '/channels',
        beforeSubmit: function() {
            return true;
        },
        success: function(data) {
            $("#result").html(JSON.stringify(data));
        } 
    });
});
