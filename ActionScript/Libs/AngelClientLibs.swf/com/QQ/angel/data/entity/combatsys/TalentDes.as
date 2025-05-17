package com.QQ.angel.data.entity.combatsys
{
   public class TalentDes
   {
      
      public static var SET:Object = {};
      
      public var id:int;
      
      public var name:String;
      
      public var description:String;
      
      public function TalentDes()
      {
         super();
      }
      
      public static function getName(param1:int) : String
      {
         if(SET[param1] == null)
         {
            param1 = 0;
         }
         return SET[param1].name;
      }
   }
}

