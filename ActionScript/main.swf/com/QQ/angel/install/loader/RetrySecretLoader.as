package com.QQ.angel.install.loader
{
   import com.QQ.angel.res.item.LogoSprite;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class RetrySecretLoader extends RetryLoader
   {
      
      private static var logoSpirte:LogoSprite = new LogoSprite();
      
      public function RetrySecretLoader(param1:Boolean = false)
      {
         super(param1);
      }
      
      override protected function onStreamComplete(param1:Event) : void
      {
         __loadState = RetryLoader.LOADER;
         stream.readBytes(currBytes);
         dealCurrBytes();
      }
      
      protected function dealCurrBytes() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         if((currBytes[0] == 67 || currBytes[0] == 70) && currBytes[1] == 87 && currBytes[2] == 83)
         {
            loadBytes(currBytes,currLC);
         }
         else
         {
            _loc1_ = new ByteArray();
            _loc1_.writeBytes(currBytes,0,2047);
            _loc1_.position = 0;
            _loc2_ = logoSpirte.setData(_loc1_);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.length - 50;
               _loc2_.position = _loc3_ + 3;
               _loc2_.writeBytes(currBytes,_loc3_,currBytes.length - _loc3_);
               _loc2_.length -= 50;
               loadBytes(_loc2_,currLC);
            }
         }
         resetTimeOut(true,2);
      }
   }
}

