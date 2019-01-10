package com.java.socket;

import com.alibaba.fastjson.JSONObject;
import com.java.view.Message;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ServerEndpoint("/echo")
public class EchoSocket {
    public EchoSocket() {
        System.out.println("创建一个新连接");
    }

    private String name;
    private static Map<String, Session> map = new HashMap<>();
    private static List<String> list = new ArrayList<>();

    @OnOpen
    public void open(Session session) throws IOException {
        System.out.println("连接成功" + session.getId());
        String queryString = session.getQueryString();
        String[] split = queryString.split("=");
        String name = split[1];
        String encode = URLDecoder.decode(name, "UTF-8");
        this.name = encode;
        list.add(this.name);
        map.put(this.name, session);
        System.out.println(map);
        Message me = new Message();
        me.setList(list);
        me.setName(this.name);
        String message = "欢迎" + this.name + "进入聊天室";
        me.setMessage(message);
        sendMessage(me);
    }

    @OnMessage
    public void mess(Session session, String mes) throws IOException {
        Message message = new Message();
        message.setName(this.name);
        message.setList(list);
        message.setMessage(mes, this.name);
        sendMessage(message);
    }

    public void sendMessage(Message mes) throws IOException {
        for (String key : map.keySet()
        )
            map.get(key).getBasicRemote().sendText(JSONObject.toJSONString(mes));
    }

    @OnClose
    public void close(Session session) {
        map.remove(this.name);
        System.out.println(map);
    }


}
