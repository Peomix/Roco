package com.QQ.angel.api
{
   import com.QQ.angel.api.media.IAudioPlayer;
   import com.QQ.angel.api.media.IEAudioManager;
   import com.QQ.angel.api.media.IVideoPlayer;
   
   public interface IMediaSysAPI
   {
       
      
      function createAudioPlayer(... rest) : IAudioPlayer;
      
      function createVideoPlayer(... rest) : IVideoPlayer;
      
      function setGlobalVolume(param1:int) : void;
      
      function getGlobalVolume() : int;
      
      function setMute(param1:Boolean) : void;
      
      function getMute() : Boolean;
      
      function getEAudioManager() : IEAudioManager;
      
      function getBGAudio() : IAudioPlayer;
   }
}
