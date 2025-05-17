package com.QQ.angel.world.scene.impl
{
   import flash.display.DisplayObjectContainer;
   
   public class SpaceLayer extends SimpleLayer
   {
      
      protected var depthMgr:DepthManager;
      
      public function SpaceLayer(param1:DisplayObjectContainer = null, param2:int = 0)
      {
         super(param1,param2);
         this.depthMgr = new DepthManager(param1);
      }
      
      public function setDMEnabled(param1:Boolean = false) : void
      {
         if(this.depthMgr != null)
         {
            this.depthMgr.setEnabled(param1);
         }
      }
      
      override public function finalize() : void
      {
         if(this.depthMgr != null)
         {
            this.depthMgr.dispose();
         }
         this.depthMgr = null;
         super.finalize();
      }
   }
}

