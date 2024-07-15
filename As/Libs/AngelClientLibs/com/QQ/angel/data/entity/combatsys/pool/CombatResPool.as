package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.data.entity.combatsys.utils.*;
   import com.QQ.angel.data.entity.combatsys.vo.*;
   import com.QQ.angel.res.BitmapDataAsset;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class CombatResPool
   {
      
      public static const resNmae:String = "Combat_";
       
      
      private var _pool:Dictionary;
      
      private var _count:uint = 0;
      
      private var _countList:Array;
      
      public function CombatResPool()
      {
         this._pool = new Dictionary();
         this._countList = [];
         super();
      }
      
      public function get pool() : Dictionary
      {
         return this._pool;
      }
      
      public function get count() : uint
      {
         return this._count;
      }
      
      public function findPoolById(param1:uint, param2:String) : CombatResVO
      {
         var _loc3_:CombatResVO = null;
         var _loc5_:String = null;
         var _loc4_:Array = [];
         for(_loc5_ in this._pool)
         {
            _loc3_ = this._pool[_loc5_];
            _loc4_ = _loc5_.split("_");
            if(!_loc3_.iscopy)
            {
               if(param1 == _loc4_[1] && param2 == _loc4_[0])
               {
                  return _loc3_;
               }
            }
            else if(_loc3_.useCount <= 0)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function findPoolByUrl(param1:String) : Array
      {
         var _loc3_:CombatResVO = null;
         var _loc4_:String = null;
         var _loc2_:Array = [];
         for(_loc4_ in this._pool)
         {
            _loc3_ = this._pool[_loc4_];
            if(_loc3_.url == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function pushResPool(param1:CombatResVO, param2:String = "") : void
      {
         var vo:CombatResVO = param1;
         var key:String = param2;
         if(vo.display is MovieClip)
         {
            try
            {
               vo.display.gotoAndStop("BLANK");
            }
            catch(e:Error)
            {
               vo.display.stop();
            }
         }
         if(key == "")
         {
            try
            {
               vo.display.name = this.toKey(vo.type,vo.id);
            }
            catch(e:Error)
            {
               throw new Event("无法命名!");
            }
            this._pool[vo.display.name] = vo;
         }
         else
         {
            this._pool[key] = vo;
         }
      }
      
      public function getResPool(param1:uint, param2:String = "") : CombatResVO
      {
         var vo:CombatResVO = null;
         var newVo:CombatResVO = null;
         var id:uint = param1;
         var type:String = param2;
         vo = this.findPoolById(id,type);
         if(vo == null)
         {
            return null;
         }
         if(vo.useCount > 0)
         {
            if(vo.display is MovieClip)
            {
               newVo = new CombatResVO();
               if(vo.Cls == null)
               {
                  vo.Cls = MovieClip(vo.display).constructor as Class;
               }
               try
               {
                  newVo.display = new vo.Cls();
               }
               catch(e:Error)
               {
                  newVo.display = new vo.Cls(0,0);
               }
               newVo.id = vo.id;
               ++newVo.useCount;
               newVo.iscopy = true;
               newVo.policy = vo.policy;
               this.pushResPool(newVo);
               return newVo;
            }
            if(vo.display is BitmapData)
            {
               ++vo.useCount;
               return vo;
            }
            if(vo.display is BitmapDataAsset)
            {
               ++vo.useCount;
               return vo;
            }
            return null;
         }
         ++vo.useCount;
         return vo;
      }
      
      public function removeResPool(param1:String, param2:int = -1) : void
      {
         var vo:CombatResVO = null;
         var name:String = param1;
         var policy:int = param2;
         vo = this._pool[name];
         if(vo == null)
         {
            return;
         }
         if(vo.display is MovieClip)
         {
            try
            {
               vo.display.gotoAndStop("BLANK");
            }
            catch(e:Error)
            {
               vo.display.stop();
            }
         }
         --vo.useCount;
         if(vo.useCount <= 0)
         {
            vo.useCount = 0;
         }
         if(policy != -1)
         {
            vo.policy = policy;
         }
         if(vo.iscopy && vo.useCount <= 0)
         {
            vo.display = null;
            vo = null;
            delete this._pool[name];
         }
         else
         {
            this.removeResByPolicy(vo,false);
         }
      }
      
      public function removeAllResPool() : void
      {
         var vo:CombatResVO = null;
         var key:String = null;
         for(key in this._pool)
         {
            vo = this._pool[key];
            if(vo.display is MovieClip)
            {
               try
               {
                  vo.display.gotoAndStop("BLANK");
               }
               catch(e:Error)
               {
                  vo.display.stop();
               }
            }
            if(vo.iscopy && vo.useCount <= 0)
            {
               vo.display = null;
               vo = null;
               delete this._pool[key];
            }
            else
            {
               this.removeResByPolicy(vo,true);
            }
         }
      }
      
      private function removeResByPolicy(param1:CombatResVO, param2:Boolean = false) : void
      {
         if(param1 == null || param1.display == null)
         {
            return;
         }
         if(param2)
         {
            if(param1.policy == CombatResType.POLICY_MODULE_TIMER)
            {
               CombatResTimerPool.getInstance().timePool[param1.display.name] = param1;
            }
            else if(param1.policy == CombatResType.POLICY_MODULE_END)
            {
               delete this._pool[param1.display.name];
               param1.display = null;
               param1 = null;
            }
         }
         else if(param1.policy == CombatResType.POLICY_DEL && param1.useCount <= 0)
         {
            delete this._pool[param1.display.name];
            param1.display = null;
            param1 = null;
         }
      }
      
      public function toKey(param1:String, param2:uint) : String
      {
         var _loc3_:uint = 0;
         if(this._countList.length > 0)
         {
            _loc3_ = this._countList.shift();
         }
         else
         {
            _loc3_ = this._count++;
         }
         return param1 + "_" + String(param2) + "_" + String(_loc3_);
      }
   }
}
