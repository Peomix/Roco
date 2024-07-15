package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_DANGERFIRECRACKER_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "danger_firecracker?cmd=0";
       
      
      public var has_get_award_scene:uint;
      
      public var has_get_award_cat:uint;
      
      public var scenes:Array;
      
      public var first:uint;
      
      public var scene_group:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_DANGERFIRECRACKER_CMD0_QueryStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            first = uint(param1.first.text());
            scene_group = uint(param1.scene_group.text());
            if(!scenes)
            {
               scenes = new Array(5);
            }
            scenes.length = 0;
            _loc2_ = param1.scenes.elements();
            for each(_loc3_ in _loc2_)
            {
               scenes.push(uint(_loc3_.text()));
            }
            has_get_award_cat = uint(param1.has_get_award_cat.text());
            has_get_award_scene = uint(param1.has_get_award_scene.text());
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         return false;
      }
   }
}
