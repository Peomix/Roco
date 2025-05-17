package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.res.IResViewLogic;
   import com.QQ.angel.res.IResourcePool;
   
   public class NpcViewDes
   {
      
      public var type:int;
      
      public var typeCls:Class;
      
      public var atLayerID:int;
      
      public var src:String;
      
      public var resPool:IResourcePool;
      
      public var resViewLogic:IResViewLogic;
      
      public var height:int;
      
      public var offsetX:int;
      
      public var lazyLoad:Boolean;
      
      public var hasBorder:Boolean;
      
      public var hasClick:Boolean = true;
      
      public var ver:int = 0;
      
      public function NpcViewDes(param1:XML = null)
      {
         super();
         this.analyse(param1);
      }
      
      public function analyse(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.type = int(param1.@type);
         this.lazyLoad = String(param1.@lazyLoad) == "true";
         this.hasClick = String(param1.@hasClick) != "false";
         if(param1.@height != undefined)
         {
            this.height = int(param1.@height);
         }
         else
         {
            this.height = -1;
         }
         this.offsetX = int(param1.@offsetX);
         this.src = DEFINE.addVersion(param1.@src);
         this.atLayerID = int(param1.@atLayerID);
         this.hasBorder = String(param1.@hasBorder) == "true";
         if(param1.@ver != undefined)
         {
            this.ver = int(param1.@ver);
         }
      }
   }
}

