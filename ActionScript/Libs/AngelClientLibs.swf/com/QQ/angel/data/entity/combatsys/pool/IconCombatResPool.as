package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.utils.CombatResType;
   import com.QQ.angel.data.entity.combatsys.vo.CombatLoadResVO;
   import com.QQ.angel.data.entity.combatsys.vo.CombatResVO;
   import flash.display.BitmapData;
   import flash.utils.getDefinitionByName;
   
   public class IconCombatResPool extends CombatResPool implements ICombatResPool
   {
      
      public function IconCombatResPool()
      {
         super();
      }
      
      public function onCompleteHandler(param1:ResData = null) : void
      {
      }
      
      public function splicePath(param1:CombatLoadResVO) : Boolean
      {
         return false;
      }
      
      override public function getResPool(param1:uint, param2:String = "") : CombatResVO
      {
         var _loc4_:String = null;
         var _loc5_:BitmapData = null;
         var _loc3_:CombatResVO = super.getResPool(param1,param2);
         if(_loc3_ == null)
         {
            _loc4_ = "com.QQ.angel.combat.icon.ICON_" + param1;
            _loc3_ = new CombatResVO();
            _loc3_.id = param1;
            _loc3_.type = "";
            _loc3_.policy = CombatResType.POLICY_DEFAULT;
            _loc3_.Cls = null;
            try
            {
               _loc3_.Cls = getDefinitionByName(_loc4_) as Class;
            }
            catch(e:Error)
            {
            }
            if(_loc3_.Cls != null)
            {
               _loc3_.display = new _loc3_.Cls(0,0);
            }
            else
            {
               _loc5_ = new BitmapData(30,30,true,0);
               _loc3_.display = _loc5_;
            }
            pushResPool(_loc3_,param2);
         }
         return _loc3_;
      }
   }
}

