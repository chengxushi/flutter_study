package com.study.flutter_study;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.util.Log;
import android.view.View;
import android.widget.RemoteViews;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * @author huang
 * @Date 2020/6/2
 * @function
 * @Notes
 * @email a12162266@163.com
 */
public class AudioService extends BaseService implements MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener, MediaPlayer.OnPreparedListener, NotificationEdit {
    private MediaPlayer mMediaPlay;
    private Context mContext;
    private Bitmap image;
    //通知栏
    private NotificationSupport notificationSupport;
    private Map<String, Bitmap> imageMap;//存储通知栏的图片
    @Override
    protected void initData(Context context) {
        imageMap = new HashMap<>();
        mContext = context;
        
        mMediaPlay = new MediaPlayer();
        mMediaPlay.setOnCompletionListener(this);
        mMediaPlay.setOnErrorListener(this);
        mMediaPlay.setOnPreparedListener(this);
        mMediaPlay.setAudioStreamType(AudioManager.STREAM_MUSIC);
        //初始化通知栏
        notificationSupport = new NotificationSupport(context, R.mipmap.logo_circle, R.layout.notification_play, this);
        
    }
    
    @Override
    protected void initBiz() {
    
    }
    
    @Override
    protected void SendToService(Object... obj) {
    
    }
    
    @Override
    protected void unBind() {
    
    }
    
    @Override
    protected void serviceDie() {
    
    }
    
    @Override
    public void initNotificationView(RemoteViews mRemoteViews) {
        Log.d("msgg", "initNotificationView");
        String title = "这是标题";
    
        mRemoteViews.setViewVisibility(R.id.iv_AudioNext, View.VISIBLE);
        returnBitMap("https://public.bobolaile.com/upload/20200411/e0b13c2a65604dd98f616b69ad598cbf.jpg");
        mRemoteViews.setImageViewBitmap(
                R.id.iv_NImage,
                image);
        mRemoteViews.setTextViewText(R.id.tv_NTitle, title);//
        mRemoteViews.setImageViewResource(R.id.iv_NPlay, R.mipmap.icon_audiobar_play);
    
    
        ((AudioManager) mContext.getSystemService(Context.AUDIO_SERVICE)).requestAudioFocus(null, AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN);
        try {
            mMediaPlay.setDataSource("https://public.bobolaile.com/upload/20200411/ea45d2dd716443cba37531072cc07542.mp3");
            // 通过异步的方式装载媒体资源
            mMediaPlay.prepareAsync();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    public Bitmap returnBitMap(final String url){
        
        new Thread(new Runnable() {
            @Override
            public void run() {
                URL imageurl = null;
                
                try {
                    imageurl = new URL(url);
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                }
                try {
                    HttpURLConnection conn = (HttpURLConnection)imageurl.openConnection();
                    conn.setDoInput(true);
                    conn.connect();
                    InputStream is = conn.getInputStream();
                    image = BitmapFactory.decodeStream(is);
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
        
        return image;
    }
    
    public  void showNotification(){
        notificationSupport.showNotification();
    }
    
    @Override
    public void onCompletion(MediaPlayer mp) {
    
    }
    
    @Override
    public boolean onError(MediaPlayer mp, int what, int extra) {
        return false;
    }
    
    @Override
    public void onPrepared(MediaPlayer mp) {
        //装载完毕回调
        mMediaPlay.start();
    }
}
