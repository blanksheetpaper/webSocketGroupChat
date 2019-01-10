package com.java;

import javax.websocket.Endpoint;
import javax.websocket.server.ServerApplicationConfig;
import javax.websocket.server.ServerEndpointConfig;
import java.util.HashSet;
import java.util.Set;

public class DemoConfig implements ServerApplicationConfig {
    //接口方式编程
    @Override
    public Set<ServerEndpointConfig> getEndpointConfigs(Set<Class<? extends Endpoint>> set) {
        return null;
    }

    //注解方式编程
    @Override

    public Set<Class<?>> getAnnotatedEndpointClasses(Set<Class<?>> set) {
//        System.out.println("你好啊");
//        System.out.println(set);
        //返回值的意思是将扫描到的webScocket集合给返回，起到过滤的作用

        Set<Class<?>> result = new HashSet<>();
        for (Class cla : set
        ) {
            boolean name = cla.getPackage().getName().endsWith(".socket");
            System.out.println(name);
        }
        return set;
    }
}
