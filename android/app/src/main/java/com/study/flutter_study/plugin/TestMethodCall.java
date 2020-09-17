package com.study.flutter_study.plugin;

import android.util.Log;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author huang
 * @Date 2020/9/15
 * @function
 * @Notes
 * @email a12162266@163.com
 */
public class TestMethodCall implements MethodChannel.MethodCallHandler {
    
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method){
            case "send":
                Log.d("flutter端传过来的参数", ""+call.argument("text")+call.argument("num"));
                Map<String, Object>  map = new HashMap<>();
                map.put("text", "回传的文字");
                map.put("num", 1);
                result.success(map);
                break;
            default:
                Log.d("flutter端传过来的参数: ", "没有这个方法");
                result.error("error", "没有这个方法", null);
                break;
        }
    }
}
