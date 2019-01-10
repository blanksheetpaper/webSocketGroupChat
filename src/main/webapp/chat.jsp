<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2019/1/3
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="js/jquery-1.7.1.js"></script>
    <style type="text/css">
        #div1 {
            border: 1px solid red;
            height: 300px;
            width: 500px;
        }

        #div1 div {
            position: relative;
            border: 1px solid black;
        }

        #div2 {
            float: left;
            width: 80%;
            height: 80%;
        }

        #div3 {
            float: right;
            width: 19.2%;
            height: 99.7%;
        }

        #div4 {
            width: 80%;
            height: 19%;
            float: left;

        }
    </style>
</head>
<body>
<h1>欢迎</h1>

<script type="text/javascript">

    <% String userName = (String) session.getAttribute("userName"); %>

    var ws;
    var userName = "<%=userName%>";
    // console.log(sessionStorage.getItem("userName"));
    var target = "ws://localhost:8080/echo?userName=" + userName;
    window.onload = function (ev) {
        if ("WebSocket" in window) {
            //target  代表的是连接服务端的地址
            ws = new WebSocket(target);
        } else if ("MozWebSocket" in window) {
            ws = new MozWebSocket(target);
        } else {
            alert("WebSocket is not supported");
            return;
        }

        ws.onmessage = function (ev1) {
            let data = ev1.data;
            data = JSON.parse(data);
            let div2 = "<p>" + data.message + "</p>";
            console.log(ev1);
            $("#div2").append(div2);
            let div3 = ``;
            for (let i = 0; i < data.list.length; i++) {
                let item = `<p>` + data.list[i] + `</p>`;
                div3 += item;
            }
            $("#div3").html(div3)
        }

    };

    function doSend() {
        var element = document.getElementById("sendText");
        ws.send(element.value);
    }

</script>


<div id="div1">
    <div id="div2">

    </div>
    <div id="div3">

    </div>
    <div id="div4">
        <input type="text" id="sendText"/>
        <button onclick="doSend()">发送</button>
    </div>
</div>
</body>
</html>
