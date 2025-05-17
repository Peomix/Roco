package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.vo.*;
   import flash.events.ErrorEvent;
   
   public class BuffCombatResPool implements ICombatResPool
   {
      
      private static var TAG:String = null;
      
      private var linkArray:Array = ["Effect_10001","Effect_10002","Effect_10003","Effect_10004","Effect_10005","Effect_10006","Effect_10007","Effect_10008","Effect_10009","Effect_10010","Effect_10011","Effect_10012","Effect_10013","Effect_20001","Effect_20002","Effect_20003","Effect_20004","Effect_20005","Effect_20006","Effect_20007","Effect_20008","Effect_20009","Effect_20010","Effect_20011","Effect_20012","Effect_20013","Effect_30001","Effect_30002","Effect_30003","Effect_30004","Effect_30005","Effect_30006","Effect_30007","Effect_30008","Effect_30009","Effect_30010","Effect_30011","Effect_40001","Effect_40002","Effect_40003","Effect_40004","Effect_40005","Effect_40006","Effect_40007","Effect_50001","Effect_60001"];
      
      private var _pool:CombatResPool;
      
      public function BuffCombatResPool()
      {
         super();
      }
      
      public function set pool(param1:CombatResPool) : void
      {
         this._pool = param1;
      }
      
      public function onCompleteHandler(param1:ResData = null) : void
      {
         var vo:CombatResVO = null;
         var linkName:String = null;
         var Cls:Class = null;
         var resData:ResData = param1;
         TAG = "onLoad";
         var resVo:CombatLoadResVO = resData.obj as CombatLoadResVO;
         var i:uint = 0;
         var len:uint = this.linkArray.length;
         i = 0;
         while(i < len)
         {
            linkName = this.linkArray[i];
            try
            {
               vo = new CombatResVO();
               Cls = resData.domain.getDefinition(linkName) as Class;
               vo.Cls = Cls;
               vo.display = new Cls();
               vo.id = int(linkName.split("_")[1]);
               vo.type = resVo.type;
               vo.url = "buff_noUrl";
               vo.useCount = 0;
               vo.iscopy = false;
               vo.policy = resVo.policy;
               this._pool.pushResPool(vo);
            }
            catch(e:Error)
            {
               throw new ErrorEvent("库中有链接名错误！");
            }
            i++;
         }
      }
      
      public function splicePath(param1:CombatLoadResVO) : Boolean
      {
         if(TAG == null)
         {
            return false;
         }
         return true;
      }
   }
}

