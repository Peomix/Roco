package com.QQ.angel.media.audio
{
   public class AudioCommands
   {
      
      public static const NOTHING:int = 1;
      
      public static const PLAY:int = 2;
      
      public static const PAUSE:int = 3;
      
      public static const STOP:int = 4;
      
      public function AudioCommands()
      {
         super();
      }
      
      public static function execute(param1:IAudioChannel, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param2)
         {
            case AudioCommands.NOTHING:
               break;
            case AudioCommands.PLAY:
               param1.play();
               break;
            case AudioCommands.PAUSE:
               param1.pause();
               break;
            case AudioCommands.STOP:
               param1.stop();
         }
      }
   }
}

