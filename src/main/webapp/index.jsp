<html>
<body>
<h2>Hello World!</h2>
<button onclick="subOpen()">open</button>


<script type="text/javascript">
    var ws;  //一个ws对象就是一个通信管道
    var target = "ws://localhost:8080/echo";

    function subOpen() {
        if ("WebSocket" in window) {
            //target  代表的是连接服务端的地址
            ws = new WebSocket(target);
        } else if ("MozWebSocket" in window) {
            ws = new MozWebSocket(target);
        } else {
            alert("WebSocket is not supported")
            return;
        }
    }

</script>
</body>
</html>
