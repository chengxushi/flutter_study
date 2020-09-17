package com.study.flutter_study.plugin;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * @author huang
 * @Date 2020/9/15
 * @function
 * @Notes
 * @email a12162266@163.com
 */
public class TestPlugin implements FlutterPlugin, ActivityAware {
    private static final String CHANNEL = "plugin.channel.data";
    private TestMethodCall handler;
    private MethodChannel methodChannel;
    // 为了在 onAttachedToActivity() 中得到 PlatformViewRegistry
    private FlutterPluginBinding pluginBinding;
    private Context mContext;

    public static void registerWith(Registrar registrar){
        TestPlugin plugin = new TestPlugin();
        plugin.setUpChannel(registrar.context(), registrar.activity(), registrar.messenger());
    }

    public void setUpChannel(Context context, Activity activity, BinaryMessenger messenger){
        methodChannel = new MethodChannel(messenger, CHANNEL);
        handler = new TestMethodCall();
        methodChannel.setMethodCallHandler(handler);
        mContext = context;
    }
    
    ///FlutterPlugin
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        setUpChannel(binding.getApplicationContext(), null, binding.getBinaryMessenger());
        pluginBinding = binding;
    }
    
    ///FlutterPlugin
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }
    
    ///ActivityAware获取生命周期相关
    //附加到活动
    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        //注册AndroidView
        HiddenLifecycleReference reference = (HiddenLifecycleReference) binding.getLifecycle();
        Lifecycle lifecycle = reference.getLifecycle();
        pluginBinding.getPlatformViewRegistry().registerViewFactory("android_view", new TestViewFactory(binding.getActivity(), lifecycle, mContext));
    }
    ///ActivityAware获取生命周期相关
    @Override
    public void onDetachedFromActivityForConfigChanges() {
    
    }
    ///ActivityAware获取生命周期相关
    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    
    }
    ///ActivityAware获取生命周期相关
    @Override
    public void onDetachedFromActivity() {
    
    }
}
