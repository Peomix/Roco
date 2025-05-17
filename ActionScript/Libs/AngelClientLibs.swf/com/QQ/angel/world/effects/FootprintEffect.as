package com.QQ.angel.world.effects
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.utils.Tween;
   import com.QQ.angel.world.utils.ObjectPool;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class FootprintEffect
   {
      
      private static var _canvs:Sprite;
      
      private static var switchFoot:Boolean;
      
      private static const FOOTPRINT_INTERVAL:int = 100;
      
      private static const FOOTPRINT_FADE_OUT_TIME:Number = 2;
      
      private static const FOOT_GAP:int = 9;
      
      private var _layer:DisplayObjectContainer;
      
      private var _role:DisplayObject;
      
      private var _footprintList:Array = [];
      
      private var _footprintCls:Class;
      
      private var _si:int;
      
      private var _roleLastLocation:Point;
      
      public function FootprintEffect()
      {
         super();
         this._layer = __global.sceneWatcher.getCurrentLogic().getGroundLayer().getContainer();
      }
      
      public function init(param1:Class, param2:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         this._footprintCls = param1;
         this._role = param2;
         if(!_canvs)
         {
            _canvs = new Sprite();
            _canvs.mouseChildren = false;
            _canvs.mouseEnabled = false;
            this._layer.addChild(_canvs);
         }
         clearInterval(this._si);
         this._si = setInterval(this.onInterval,FOOTPRINT_INTERVAL);
      }
      
      public function stop() : void
      {
         this.clearAll();
         clearInterval(this._si);
         if(Boolean(_canvs) && Boolean(_canvs.parent))
         {
            _canvs.parent.removeChild(_canvs);
         }
         if(_canvs)
         {
            _canvs = null;
         }
         this._roleLastLocation = null;
         this._role = null;
      }
      
      protected function onInterval(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!this._role)
         {
            return;
         }
         if(this._roleLastLocation)
         {
            if(this._roleLastLocation.x == this._role.x && this._roleLastLocation.y == this._role.y)
            {
               return;
            }
            _loc2_ = this._role.x - this._roleLastLocation.x;
            _loc3_ = this._role.y - this._roleLastLocation.y;
            _loc4_ = Math.atan2(_loc3_,_loc2_);
            _loc5_ = Math.sin(_loc4_);
            _loc6_ = Math.cos(_loc4_);
            if(this._roleLastLocation.x < this._role.x)
            {
               this.addFootprint(this._role.x,this._role.y,_loc5_,_loc6_,1);
            }
            else
            {
               this.addFootprint(this._role.x,this._role.y,_loc5_,_loc6_,-1);
            }
            this._roleLastLocation.x = this._role.x;
            this._roleLastLocation.y = this._role.y;
         }
         else
         {
            this._roleLastLocation = new Point();
            this._roleLastLocation.x = this._role.x;
            this._roleLastLocation.y = this._role.y;
         }
      }
      
      private function addFootprint(param1:int, param2:int, param3:Number, param4:Number, param5:int) : void
      {
         var _loc6_:MovieClip = null;
         switchFoot = !switchFoot;
         _loc6_ = ObjectPool.getObject(this._footprintCls) as MovieClip;
         if(!_loc6_)
         {
            return;
         }
         _loc6_.alpha = 1;
         _loc6_.mouseChildren = false;
         _loc6_.mouseEnabled = false;
         _loc6_.play();
         if(switchFoot)
         {
            _loc6_.x = param1 + param3 * FOOT_GAP;
            _loc6_.y = param2 - param4 * FOOT_GAP;
         }
         else
         {
            _loc6_.x = param1 - param3 * FOOT_GAP;
            _loc6_.y = param2 + param4 * FOOT_GAP;
         }
         this._footprintList[this._footprintList.length] = _loc6_;
         _loc6_.scaleX = param5;
         if(_canvs)
         {
            _canvs.addChild(_loc6_);
         }
         Tween.to(_loc6_,FOOTPRINT_FADE_OUT_TIME,{
            "x":_loc6_.x,
            "y":_loc6_.y,
            "alpha":0.1
         },null,this.clear);
      }
      
      private function clear() : void
      {
         var _loc1_:MovieClip = null;
         if(Boolean(this._footprintList) && this._footprintList.length > 0)
         {
            _loc1_ = this._footprintList.shift() as MovieClip;
            if(Boolean(_loc1_) && Boolean(_loc1_.parent))
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.stop();
            ObjectPool.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      private function clearAll() : void
      {
         var _loc1_:MovieClip = null;
         if(this._footprintList)
         {
            while(this._footprintList.length)
            {
               _loc1_ = this._footprintList.shift() as MovieClip;
               if(Boolean(_loc1_) && Boolean(_loc1_.parent))
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.stop();
               ObjectPool.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
   }
}

