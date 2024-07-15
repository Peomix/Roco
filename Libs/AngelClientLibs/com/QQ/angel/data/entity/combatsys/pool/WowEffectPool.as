package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.vo.WowEffectCombatResVO;
   import com.QQ.angel.res.BitmapDataAsset;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class WowEffectPool implements IWowCombatResPool
   {
      
      public static const resNmaeList:Array = ["effect_0","effect_1","effect_2"];
       
      
      private var _pool:Dictionary;
      
      private var _count:uint = 0;
      
      private var _countList:Array;
      
      public function WowEffectPool()
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
      
      public function findPoolById(param1:uint, param2:String) : WowEffectCombatResVO
      {
         var _loc3_:WowEffectCombatResVO = null;
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
      
      public function onCompleteHandler(param1:ResData = null) : void
      {
         var vo:WowEffectCombatResVO = null;
         var Cls0:Class = null;
         var Cls1:Class = null;
         var Cls2:Class = null;
         var asset:BitmapDataAsset = null;
         var resData:ResData = param1;
         var resVo:WowEffectCombatResVO = resData.obj as WowEffectCombatResVO;
         vo = new WowEffectCombatResVO();
         try
         {
            Cls0 = resData.domain.getDefinition(resNmaeList[0]) as Class;
            Cls1 = resData.domain.getDefinition(resNmaeList[1]) as Class;
            Cls2 = resData.domain.getDefinition(resNmaeList[2]) as Class;
            vo.Cls0 = Cls0;
            vo.Cls1 = Cls1;
            vo.Cls2 = Cls2;
            try
            {
               vo.display = new Cls0();
            }
            catch(error:Error)
            {
               vo.display = new Cls1(0,0);
            }
         }
         catch(error:Error)
         {
            vo.Cls0 = null;
            vo.Cls1 = null;
            vo.Cls2 = null;
            if(resData.content is MovieClip)
            {
               vo.display = resData.content;
            }
            else if(resData.content is Bitmap)
            {
               asset = new BitmapDataAsset();
               asset.bimapdata = resData.content.bitmapData;
               vo.display = asset;
            }
         }
         vo.id = resVo.id;
         vo.type = resVo.type;
         vo.url = resVo.url;
         vo.useCount = 0;
         vo.iscopy = false;
         vo.policy = resVo.policy;
         this.pushResPool(vo);
         if(resVo.callBack != null)
         {
            ++vo.useCount;
            resVo.callBack(vo.display);
         }
      }
      
      public function findPoolByUrl(param1:String) : Array
      {
         var _loc3_:WowEffectCombatResVO = null;
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
      
      public function splicePath(param1:WowEffectCombatResVO) : Boolean
      {
         var vo:WowEffectCombatResVO = null;
         var tempVo:WowEffectCombatResVO = null;
         var arr:Array = null;
         var i:uint = 0;
         var len:uint = 0;
         var combatResVo:WowEffectCombatResVO = null;
         var ssvo:WowEffectCombatResVO = null;
         var loadResVo:WowEffectCombatResVO = param1;
         arr = this.findPoolByUrl(loadResVo.url);
         if(arr.length == 0)
         {
            return false;
         }
         i = 0;
         len = arr.length;
         i = 0;
         while(i < len)
         {
            vo = arr[i];
            if(vo.id == loadResVo.id)
            {
               if(loadResVo.callBack != null)
               {
                  combatResVo = this.getResPool(vo.id,vo.type);
                  loadResVo.callBack(combatResVo.display);
               }
               return true;
            }
            tempVo = vo;
            i++;
         }
         if(tempVo != null)
         {
            if(tempVo.Cls0 == null)
            {
               return false;
            }
            ssvo = new WowEffectCombatResVO();
            ssvo.copy(tempVo);
            ssvo.id = loadResVo.id;
            ssvo.type = loadResVo.type;
            try
            {
               ssvo.display = new ssvo.Cls0();
            }
            catch(error:Error)
            {
               ssvo.display = new ssvo.Cls0(0,0);
            }
            ssvo.policy = loadResVo.policy;
            if(loadResVo.callBack != null)
            {
               this.getResPool(ssvo.id,ssvo.type);
               loadResVo.callBack(tempVo.display);
            }
            this.pushResPool(ssvo);
         }
         return true;
      }
      
      public function getResPool(param1:uint, param2:String = "") : WowEffectCombatResVO
      {
         var vo:WowEffectCombatResVO = null;
         var newVo:WowEffectCombatResVO = null;
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
               newVo = new WowEffectCombatResVO();
               if(vo.Cls0 == null)
               {
                  newVo.Cls0 = MovieClip(vo.display).constructor as Class;
                  newVo.Cls1 = vo.Cls1;
                  newVo.Cls2 = vo.Cls2;
               }
               else
               {
                  newVo.Cls0 = vo.Cls0;
                  newVo.Cls1 = vo.Cls1;
                  newVo.Cls2 = vo.Cls2;
               }
               try
               {
                  newVo.display = new vo.Cls0();
               }
               catch(e:Error)
               {
                  newVo.display = new vo.Cls0(0,0);
               }
               newVo.type = vo.type;
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
      
      public function pushResPool(param1:WowEffectCombatResVO, param2:String = "") : void
      {
         var vo:WowEffectCombatResVO = param1;
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
            key = this.toKey(vo.type,vo.id);
            this._pool[key] = vo;
         }
         else
         {
            this._pool[key] = vo;
         }
      }
      
      private function toKey(param1:String, param2:uint) : String
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
      
      public function removeAllResPool() : void
      {
         var vo:WowEffectCombatResVO = null;
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
      
      private function removeResByPolicy(param1:WowEffectCombatResVO, param2:Boolean = false) : void
      {
         if(param1 == null || param1.display == null)
         {
            return;
         }
      }
   }
}
