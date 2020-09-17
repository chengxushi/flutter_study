package com.study.flutter_study;

///flutterSDK 1.12之前引用的包, 注册插件需要手动调用
///GeneratedPluginRegistrant.registerWith方法https://guoshuyu.cn/home/wx/Flutter-update-1.12.html
//import io.flutter.app.FlutterActivity;

///flutterSDK 1.12之后引用的包, 引用这个就会自动注册插件
import com.study.flutter_study.plugin.TestPlugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        ///注册插件
        flutterEngine.getPlugins().add(new TestPlugin());
    }
}
