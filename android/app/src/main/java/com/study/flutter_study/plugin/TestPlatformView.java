package com.study.flutter_study.plugin;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.study.flutter_study.R;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import io.flutter.plugin.platform.PlatformView;

/**
 * @author huang
 * @Date 2020/9/15
 * @function
 * @Notes
 * @email a12162266@163.com
 */
public class TestPlatformView implements PlatformView, DefaultLifecycleObserver {
    private static final String TAG = "TestPlatformView";
    private Activity mActivity;
    private Context mContext;
    private View mView;
    private TextView tv_setting;

    public TestPlatformView(Activity activity, Lifecycle lifecycle, Context context) {
        Log.d(TAG, "初始化");
        lifecycle.addObserver(this);
        mActivity = activity;
        mContext = context;
//        LayoutInflater mInflater = LayoutInflater.from(mActivity);
//        mView = mInflater.inflate(R.layout.activity_setting, null, false);
        mView = View.inflate(context, R.layout.activity_setting, null);
//        tv_setting = new TextView(context);
//        tv_setting.setText("我是TextView");
////        tv_setting = mView.findViewById(R.id.tv_setting);
//        tv_setting.setOnClickListener(view -> {
//            Toast.makeText(mContext, "弹出提示", Toast.LENGTH_SHORT).show();
//        });
    }

    @Override
    public View getView() {
        Log.d(TAG, "getView");
        return mView;
    }
    
    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        Log.d(TAG, "onFlutterViewAttached");
    }
    
    @Override
    public void dispose() {
        Log.d(TAG, "dispose");
    }
    
    @Override
    public void onCreate(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onCreate");
    }
    
    @Override
    public void onStart(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onStart");
    }
    
    @Override
    public void onResume(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onResume");
    }
    
    @Override
    public void onPause(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onPause");
    }
    
    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onStop");
    }
    
    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
        Log.d(TAG, "onDestroy");
    }
}
