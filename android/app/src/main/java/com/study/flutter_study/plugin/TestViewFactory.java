package com.study.flutter_study.plugin;

import android.app.Activity;
import android.content.Context;

import androidx.lifecycle.Lifecycle;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @author huang
 * @Date 2020/9/15
 * @function
 * @Notes
 * @email a12162266@163.com
 */
public class TestViewFactory extends PlatformViewFactory {
    private Activity activity;
    private Lifecycle lifecycle;
    private Context context;

    public TestViewFactory(Activity activity, Lifecycle lifecycle, Context context){
        super(StandardMessageCodec.INSTANCE);
        this.activity = activity;
        this.lifecycle = lifecycle;
        this.context = context;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new TestPlatformView(activity, lifecycle, context);
    }
}
