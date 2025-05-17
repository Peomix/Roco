package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.utils.*;
   import com.QQ.angel.data.entity.combatsys.vo.*;
   import com.QQ.angel.res.BitmapDataAsset;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class CommonCombatResPool extends CombatResPool implements ICombatResPool
   {
      
      public function CommonCombatResPool()
      {
         super();
      }
      
      public function onCompleteHandler(param1:ResData = null) : void
      {
         var resVo:CombatLoadResVO = null;
         var vo:CombatResVO = null;
         var Cls:Class = null;
         var asset:BitmapDataAsset = null;
         var resData:ResData = param1;
         resVo = resData.obj as CombatLoadResVO;
         vo = new CombatResVO();
         try
         {
            Cls = resData.domain.getDefinition(resVo.linkName) as Class;
            vo.Cls = Cls;
            try
            {
               vo.display = new Cls();
            }
            catch(error:Error)
            {
               vo.display = new Cls(0,0);
            }
         }
         catch(error:Error)
         {
            vo.Cls = null;
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
      
      public function splicePath(param1:CombatLoadResVO) : Boolean
      {
         var vo:CombatResVO = null;
         var tempVo:CombatResVO = null;
         var arr:Array = null;
         var i:uint = 0;
         var len:uint = 0;
         var combatResVo:CombatResVO = null;
         var ssvo:CombatResVO = null;
         var loadResVo:CombatLoadResVO = param1;
         arr = findPoolByUrl(loadResVo.url);
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
            if(tempVo.Cls == null)
            {
               return false;
            }
            ssvo = new CombatResVO();
            ssvo.copy(tempVo);
            ssvo.id = loadResVo.id;
            try
            {
               ssvo.display = new ssvo.Cls();
            }
            catch(error:Error)
            {
               ssvo.display = new ssvo.Cls(0,0);
            }
            ssvo.policy = loadResVo.policy;
            if(loadResVo.callBack != null)
            {
               this.getResPool(ssvo.id,ssvo.type);
               loadResVo.callBack(tempVo.display);
            }
            pushResPool(ssvo);
         }
         return true;
      }
   }
}

