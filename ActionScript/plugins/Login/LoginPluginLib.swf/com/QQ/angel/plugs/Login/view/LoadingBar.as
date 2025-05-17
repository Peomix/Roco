package com.QQ.angel.plugs.Login.view
{
   import com.QQ.angel.ui.core.Window;
   import flash.display.DisplayObjectContainer;
   
   public class LoadingBar extends Window
   {
      
      private var _effect:LoadingEffect;
      
      public function LoadingBar(param1:DisplayObjectContainer)
      {
         super();
         _effect = new LoadingEffect();
         addChild(_effect);
         _effect.x = 960 / 2 - _effect.width / 2;
         _effect.y = 560 / 2;
         this.initialize(param1,null,null,null,true);
      }
      
      public function finalize() : void
      {
         _effect.finalize();
      }
   }
}

